import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/user_data_section.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/adding_address_title_widget.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_screen_app_bar.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_screen_container.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../generated/l10n.dart';
import '../../shared/shared_widget.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(24.7136, 46.6753);
  LatLng? _currentLocation;
  bool _isMapReady = false;

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
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(location, 15.0),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    print('🗺️ [ServiceScreen] initState() - Initializing location service');
    // Initialize location and start streaming when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('🗺️ [ServiceScreen] PostFrameCallback - Starting location initialization');
      context.read<ServiceCubit>().initializeLocation().then((_) {
        print('🗺️ [ServiceScreen] Location initialized, starting stream');
        context.read<ServiceCubit>().startLocationStream();
      });
    });
  }

  @override
  void dispose() {
    // Stop location stream when screen is disposed
    print('🗺️ [ServiceScreen] dispose() - Stopping location stream');
    if (mounted) {
      context.read<ServiceCubit>().stopLocationStream();
    }
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
          print('🗺️ [ServiceScreen] Location stream active - Lat: ${state.latitude}, Lng: ${state.longitude}');
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
          }
        } else if (state is ServiceLocationEnabled) {
          // Update location when enabled (initial location)
          print('🗺️ [ServiceScreen] Location enabled - Lat: ${state.latitude}, Lng: ${state.longitude}');
          final newLocation = LatLng(state.latitude, state.longitude);
          setState(() {
            _currentLocation = newLocation;
          });
          _updateMapCamera(newLocation);
        } else if (state is ServiceLocationError) {
          print('❌ [ServiceScreen] Location error: ${state.message}');
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ServiceLocationPermissionDenied) {
          // Show permission denied message
          print('⚠️ [ServiceScreen] Location permission denied: ${state.message}');
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
          final initialPosition = _currentLocation ?? _center;
          
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
                          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
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
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ServiceScreenAppBar(text: s.mapAddress), // ✅ localized
                      ],
                    ),
                  ),
                ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, left: 16.w, right: 16.w),
              child: UserDataSection(name: "سارة محمد",subtitle: s.client,),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 15.h)),
          SliverToBoxAdapter(
            child: AddingAddressTitleWidget(title: s.day_and_time),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 14.h,),),
          SliverToBoxAdapter(
            child: ServiceScreenContainer(title: s.day_time_for_service,subtitle:"AM 05:00" ,),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 14.h,),),
          SliverToBoxAdapter(
            child: AddingAddressTitleWidget(title: s.service_type),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 14.h,),),
                SliverToBoxAdapter(
                  child: ServiceScreenContainer(title: s.service_title,subtitle:s.car_data ,),
                ),
              ],
            ),

            floatingActionButton: DefaultButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.serviceProgressScreen);
              },
              titleWidget: Text(
                s.startService, 
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  color: Colors.white,
                ),
              ),
              width: MediaQuery.of(context).size.width / 1.8,
              borderRadius: BorderRadius.circular(24.r),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}

