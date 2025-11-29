import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/helper_functions.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/user_data_section.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/adding_address_title_widget.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_screen_app_bar.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_screen_container.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../generated/l10n.dart';
import '../../shared/shared_widget.dart';

class ServiceScreen extends StatefulWidget {
  final Order? order;

  const ServiceScreen({super.key, this.order});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(24.7136, 46.6753);
  LatLng? _currentLocation;
  bool _isMapReady = false;
  bool _isButtonEnabled = false;
  Timer? _timeValidationTimer;

  Future<void> _openNavigation() async {
    if (widget.order == null) return;

    try {
      final orderLat = double.tryParse(widget.order!.latitude) ?? 0.0;
      final orderLng = double.tryParse(widget.order!.longitude) ?? 0.0;

      if (orderLat == 0.0 || orderLng == 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).mapAddress),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await HelperFunctions.openGoogleMapsNavigation(orderLat, orderLng);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening navigation: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _checkServiceAvailability() {
    if (widget.order == null || _currentLocation == null) {
      setState(() {
        _isButtonEnabled = false;
      });
      return;
    }

    // Check time validation
    final isTimeValid = HelperFunctions.isOrderTimeValid(widget.order!);
    if (!isTimeValid) {
      setState(() {
        _isButtonEnabled = false;
      });
      return;
    }

    // Check distance validation (50 meters)
    try {
      final orderLat = double.tryParse(widget.order!.latitude) ?? 0.0;
      final orderLng = double.tryParse(widget.order!.longitude) ?? 0.0;

      if (orderLat == 0.0 || orderLng == 0.0) {
        setState(() {
          _isButtonEnabled = false;
        });
        return;
      }

      final distance = HelperFunctions.calculateDistance(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
        orderLat,
        orderLng,
      );

      setState(() {
        _isButtonEnabled = distance <= 50.0; // 50 meters
      });
    } catch (e) {
      print('❌ [ServiceScreen] Error calculating distance: $e');
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _isMapReady = true;
    // Move camera to current location if available
    if (_currentLocation != null) {
      _updateMapCamera(_currentLocation!);
    }
  }

  void _updateMapCamera(LatLng location) {
    if (_mapController != null && _isMapReady) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(location, 15.0));
    }
  }

  @override
  void initState() {
    super.initState();
    print('🗺️ [ServiceScreen] initState() - Location stream should already be running from HomeScreen');
    
    // Get current location from ServiceCubit if available
    final currentState = context.read<ServiceCubit>().state;
    if (currentState is ServiceLocationStreamActive) {
      _currentLocation = LatLng(currentState.latitude, currentState.longitude);
      print('🗺️ [ServiceScreen] Got initial location from stream: Lat: ${currentState.latitude}, Lng: ${currentState.longitude}');
    } else if (currentState is ServiceLocationEnabled) {
      _currentLocation = LatLng(currentState.latitude, currentState.longitude);
      print('🗺️ [ServiceScreen] Got initial location: Lat: ${currentState.latitude}, Lng: ${currentState.longitude}');
    }

    // Start periodic time validation check (every 10 seconds)
    _timeValidationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        _checkServiceAvailability();
      }
    });
  }

  @override
  void dispose() {
    // Don't stop location stream - it should continue running from HomeScreen
    print('🗺️ [ServiceScreen] dispose() - Location stream continues running');
    _timeValidationTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ localization instance
    return BlocListener<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state is ServiceLocationStreamActive) {
          // Update current location when stream is active
          print(
            '🗺️ [ServiceScreen] Location stream active - Lat: ${state.latitude}, Lng: ${state.longitude}',
          );
          print('   📍 Timestamp: ${state.timestamp.toIso8601String()}');
          print('   📍 Accuracy: ${state.accuracy}m, Speed: ${state.speed}m/s');
          final newLocation = LatLng(state.latitude, state.longitude);
          if (_currentLocation == null ||
              _currentLocation!.latitude != state.latitude ||
              _currentLocation!.longitude != state.longitude) {
            print('🗺️ [ServiceScreen] Updating map camera to new location');
            setState(() {
              _currentLocation = newLocation;
            });
            _updateMapCamera(newLocation);
            _checkServiceAvailability();
          }
        } else if (state is ServiceLocationEnabled) {
          // Update location when enabled (initial location)
          print(
            '🗺️ [ServiceScreen] Location enabled - Lat: ${state.latitude}, Lng: ${state.longitude}',
          );
          final newLocation = LatLng(state.latitude, state.longitude);
          setState(() {
            _currentLocation = newLocation;
          });
          _updateMapCamera(newLocation);
          // Check service availability after initial location is set
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkServiceAvailability();
          });
        } else if (state is ServiceLocationError) {
          print('❌ [ServiceScreen] Location error: ${state.message}');
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is ServiceLocationPermissionDenied) {
          // Show permission denied message
          print(
            '⚠️ [ServiceScreen] Location permission denied: ${state.message}',
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.orange,
              action: SnackBarAction(
                label: 'Settings',
                textColor: Colors.white,
                onPressed: () {
                  openAppSettings();
                },
              ),
            ),
          );
        }
      },
      child: BlocBuilder<ServiceCubit, ServiceState>(
        builder: (context, state) {
          // Determine initial camera position
          LatLng? orderLocation;
          if (widget.order != null) {
            try {
              final orderLat = double.tryParse(widget.order!.latitude) ?? 0.0;
              final orderLng = double.tryParse(widget.order!.longitude) ?? 0.0;
              if (orderLat != 0.0 && orderLng != 0.0) {
                orderLocation = LatLng(orderLat, orderLng);
              }
            } catch (e) {
              print('❌ [ServiceScreen] Error parsing order location: $e');
            }
          }

          final initialPosition = _currentLocation ?? orderLocation ?? _center;

          // Format date and time for display
          String formattedDate = '';
          String formattedTime = '';
          String serviceDescription = '';
          String carData = '';
          if (widget.order != null) {
            formattedDate = HelperFunctions.formatOrderDateWithDayName(
              widget.order!,
            );
            formattedTime = HelperFunctions.formatOrderDateTimeForService(
              widget.order!,
            );
            serviceDescription = HelperFunctions.getServiceDescription(
              widget.order!,
            );
            if (serviceDescription.isEmpty) {
              serviceDescription = s.service_title;
            }
            carData = HelperFunctions.formatCarData(widget.order!);
            if (carData.isEmpty) {
              carData = s.car_data;
            }
          }
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Stack(
                      children: [
                        GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: initialPosition,
                            zoom: _currentLocation != null ? 15.0 : 12.0,
                          ),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>{
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              },
                        ),
                        // Show loading indicator when location is loading
                        if (state is ServiceLocationLoading)
                          Container(
                            color: Colors.black.withValues(alpha: 0.3),
                            child: Center(
                              child: AppLoader(),
                            ),
                          ),
                        ServiceScreenAppBar(
                          text: widget.order?.locationAddress ?? s.mapAddress,
                        ),
                        // Navigation button
                        if (widget.order != null)
                          Positioned(
                            bottom: 20.h,
                            right: 16.w,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white,
                              child: InkWell(
                                onTap: _openNavigation,
                                borderRadius: BorderRadius.circular(12.r),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.navigation,
                                        color: Colors.blue,
                                        size: 24.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Navigate',
                                        style: AppTextStyle
                                            .blackW600Size14Roboto
                                            .copyWith(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: UserDataSection(
                      name: widget.order?.customerName ?? '',
                      subtitle: widget.order?.locationAddress ?? s.mapAddress,
                      phoneNumber: widget.order?.customerPhone,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                SliverToBoxAdapter(
                  child: AddingAddressTitleWidget(title: s.day_and_time),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                SliverToBoxAdapter(
                  child: ServiceScreenContainer(
                    title: formattedDate.isNotEmpty
                        ? formattedDate
                        : s.day_time_for_service,
                    subtitle: formattedTime.isNotEmpty
                        ? formattedTime
                        : s.day_time_for_service,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                SliverToBoxAdapter(
                  child: AddingAddressTitleWidget(title: s.service_type),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                SliverToBoxAdapter(
                  child: ServiceScreenContainer(
                    title: serviceDescription.isNotEmpty
                        ? serviceDescription
                        : s.service_title,
                    subtitle: carData.isNotEmpty
                        ? carData
                        : s.car_data,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 80.h)),

              ],
            ),

            floatingActionButton: DefaultButton(
              onPressed: _isButtonEnabled
                  ? () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.serviceProgressScreen);
                    }
                  : null,
              titleWidget: Text(
                s.startService,
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  color: Colors.white,
                ),
              ),
              width: MediaQuery.of(context).size.width / 1.8,
              borderRadius: BorderRadius.circular(24.r),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
