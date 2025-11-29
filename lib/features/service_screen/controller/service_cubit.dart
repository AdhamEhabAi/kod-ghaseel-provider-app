import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/data/models/order_stages_model.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/data/repo/service_repo.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final ServiceRepo _serviceRepo;
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isStreaming = false;
  Timer? _locationUpdateTimer;
  double? _lastLatitude;
  double? _lastLongitude;

  ServiceCubit(this._serviceRepo) : super(ServiceInitial());

  /// Initialize location service and request permissions
  Future<void> initializeLocation() async {
    print('📍 [ServiceCubit] initializeLocation() called');
    developer.log(
      '📍 [ServiceCubit] initializeLocation() called',
      name: 'Location',
    );
    emit(ServiceLocationLoading());

    try {
      // Check and request location service
      bool serviceEnabled = await _serviceRepo.isLocationServiceEnabled();
      print('📍 [ServiceCubit] Location service enabled: $serviceEnabled');
      if (!serviceEnabled) {
        serviceEnabled = await _serviceRepo.requestLocationService();
        print(
          '📍 [ServiceCubit] Location service requested, enabled: $serviceEnabled',
        );
        if (!serviceEnabled) {
          print('❌ [ServiceCubit] Location service denied');
          emit(
            ServiceLocationPermissionDenied(
              'Location services are disabled. Please enable them in settings.',
            ),
          );
          return;
        }
      }

      // Check and request location permissions
      PermissionStatus permissionStatus = await _serviceRepo
          .getLocationPermissionStatus();
      print('📍 [ServiceCubit] Location permission status: $permissionStatus');

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _serviceRepo.requestLocationPermission();
        print(
          '📍 [ServiceCubit] Location permission requested, status: $permissionStatus',
        );
      }

      // For Android, also request background location permission
      if (Platform.isAndroid) {
        if (permissionStatus == PermissionStatus.granted) {
          // Request background location permission for Android 10+
          final backgroundPermission = await Permission.locationAlways.status;
          print(
            '📍 [ServiceCubit] Background location permission status: $backgroundPermission',
          );
          if (backgroundPermission.isDenied) {
            await Permission.locationAlways.request();
            print('📍 [ServiceCubit] Background location permission requested');
          }
        }
      }

      if (permissionStatus != PermissionStatus.granted) {
        print('❌ [ServiceCubit] Location permission not granted');
        emit(
          ServiceLocationPermissionDenied(
            'Location permission is required to track your position.',
          ),
        );
        return;
      }

      // Configure location settings for background tracking
      bool configured = await _serviceRepo.configureLocationSettings();
      print('📍 [ServiceCubit] Location settings configured: $configured');
      if (!configured) {
        emit(ServiceLocationError('Failed to configure location settings.'));
        return;
      }

      // Get initial location
      final locationData = await _serviceRepo.getCurrentLocation();
      if (locationData != null) {
        print(
          '📍 [ServiceCubit] Initial location received - Lat: ${locationData.latitude}, Lng: ${locationData.longitude}, Accuracy: ${locationData.accuracy}m',
        );

        // Store initial location for API updates
        if (locationData.latitude != null && locationData.longitude != null) {
          _lastLatitude = locationData.latitude;
          _lastLongitude = locationData.longitude;
        }

        emit(
          ServiceLocationEnabled(
            latitude: locationData.latitude ?? 0.0,
            longitude: locationData.longitude ?? 0.0,
            accuracy: locationData.accuracy,
            altitude: locationData.altitude,
            speed: locationData.speed,
            timestamp: DateTime.now(),
          ),
        );
      } else {
        print('❌ [ServiceCubit] Unable to get current location');
        emit(ServiceLocationError('Unable to get current location.'));
      }
    } catch (e) {
      print('❌ [ServiceCubit] Error initializing location: $e');
      emit(
        ServiceLocationError('Error initializing location: ${e.toString()}'),
      );
    }
  }

  /// Start location streaming (works in background)
  Future<void> startLocationStream() async {
    if (_isStreaming) {
      print('📍 [ServiceCubit] Location stream already active');
      return; // Already streaming
    }

    print('📍 [ServiceCubit] startLocationStream() called');

    try {
      // Ensure permissions are granted
      PermissionStatus permissionStatus = await _serviceRepo
          .getLocationPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        print('📍 [ServiceCubit] Permission not granted, initializing...');
        await initializeLocation();
        permissionStatus = await _serviceRepo.getLocationPermissionStatus();
        if (permissionStatus != PermissionStatus.granted) {
          print(
            '❌ [ServiceCubit] Permission still not granted after initialization',
          );
          emit(
            ServiceLocationPermissionDenied(
              'Location permission is required to track your position.',
            ),
          );
          return;
        }
      }

      // Configure location settings
      await _serviceRepo.configureLocationSettings();

      _locationSubscription = _serviceRepo.getLocationStream().listen(
        (LocationData locationData) {
          if (locationData.latitude != null && locationData.longitude != null) {
            final timestamp = DateTime.now();
            developer.log(
              '📍 [BACKGROUND] Location - Lat: ${locationData.latitude}, Lng: ${locationData.longitude}, Accuracy: ${locationData.accuracy}m',
              name: 'Location',
            );

            // Update last known location
            _lastLatitude = locationData.latitude;
            _lastLongitude = locationData.longitude;

            emit(
              ServiceLocationStreamActive(
                latitude: locationData.latitude!,
                longitude: locationData.longitude!,
                accuracy: locationData.accuracy,
                altitude: locationData.altitude,
                speed: locationData.speed,
                timestamp: timestamp,
              ),
            );
          } else {
            print(
              '⚠️ [ServiceCubit] Location data received but lat/lng is null',
            );
          }
        },
        onError: (error) {
          print('❌ [ServiceCubit] Location stream error: $error');
          developer.log(
            '❌ Location stream error: $error',
            name: 'Location',
            error: error,
          );
          emit(
            ServiceLocationError('Location stream error: ${error.toString()}'),
          );
        },
        cancelOnError: false,
      );

      // Start periodic location update to server (every 30 seconds)
      _startLocationUpdateTimer();

      _isStreaming = true;
      print('✅ [ServiceCubit] Location stream started successfully');
      developer.log('✅ Location stream started', name: 'Location');
    } catch (e) {
      print('❌ [ServiceCubit] Error starting location stream: $e');
      emit(
        ServiceLocationError('Error starting location stream: ${e.toString()}'),
      );
    }
  }

  void _startLocationUpdateTimer() {
    _locationUpdateTimer?.cancel();
    print(
      '⏰ [ServiceCubit] Starting location update timer (30 seconds interval)',
    );

    // Send initial location update immediately if available
    if (_lastLatitude != null && _lastLongitude != null) {
      _updateLocationOnServer(_lastLatitude!, _lastLongitude!);
    }

    // Then update every 30 seconds
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_lastLatitude != null && _lastLongitude != null && _isStreaming) {
        _updateLocationOnServer(_lastLatitude!, _lastLongitude!);
      } else {
        print(
          '⚠️ [ServiceCubit] Skipping location update - no location data or stream not active',
        );
      }
    });
  }

  /// Update location on server
  Future<void> _updateLocationOnServer(
    double latitude,
    double longitude,
  ) async {
    try {
      final result = await _serviceRepo.updateDeliveryLocation(
        latitude: latitude,
        longitude: longitude,
      );

      result.fold(
        (failure) {
          print(
            '❌ [ServiceCubit] Failed to update location on server: ${failure.message}',
          );
        },
        (data) {
          print('✅ [ServiceCubit] Location updated on server successfully');
        },
      );
    } catch (e) {
      print('❌ [ServiceCubit] Error updating location on server: $e');
    }
  }

  /// Stop location streaming
  Future<void> stopLocationStream() async {
    print('🛑 [ServiceCubit] stopLocationStream() called');

    // Cancel location update timer
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;

    await _locationSubscription?.cancel();
    _locationSubscription = null;
    _isStreaming = false;
    _lastLatitude = null;
    _lastLongitude = null;

    print('✅ [ServiceCubit] Location stream stopped');
    emit(ServiceInitial());
  }

  Future<void> getCurrentLocation() async {
    print('📍 [ServiceCubit] getCurrentLocation() called');
    emit(ServiceLocationLoading());

    try {
      // Check permissions
      PermissionStatus permissionStatus = await _serviceRepo
          .getLocationPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        await initializeLocation();
        permissionStatus = await _serviceRepo.getLocationPermissionStatus();
        if (permissionStatus != PermissionStatus.granted) {
          print(
            '❌ [ServiceCubit] Permission not granted for getCurrentLocation',
          );
          emit(
            ServiceLocationPermissionDenied('Location permission is required.'),
          );
          return;
        }
      }

      final locationData = await _serviceRepo.getCurrentLocation();
      if (locationData != null &&
          locationData.latitude != null &&
          locationData.longitude != null) {
        print(
          '📍 [ServiceCubit] Current location - Lat: ${locationData.latitude}, Lng: ${locationData.longitude}',
        );
        emit(
          ServiceLocationEnabled(
            latitude: locationData.latitude!,
            longitude: locationData.longitude!,
            accuracy: locationData.accuracy,
            altitude: locationData.altitude,
            speed: locationData.speed,
            timestamp: DateTime.now(),
          ),
        );
      } else {
        print('❌ [ServiceCubit] Unable to get current location');
        emit(ServiceLocationError('Unable to get current location.'));
      }
    } catch (e) {
      print('❌ [ServiceCubit] Error getting location: $e');
      emit(ServiceLocationError('Error getting location: ${e.toString()}'));
    }
  }

  /// Get order stages
  Future<void> getOrderStages(int deliveryOrderId) async {
    print('📋 [ServiceCubit] getOrderStages() called for order: $deliveryOrderId');
    emit(OrderStagesLoading());

    final result = await _serviceRepo.getOrderStages(
      deliveryOrderId: deliveryOrderId,
    );

    result.fold(
      (failure) {
        print('❌ [ServiceCubit] Failed to get order stages: ${failure.message}');
        emit(OrderStagesError(failure.message));
      },
      (data) {
        try {
          print('✅ [ServiceCubit] Order stages loaded successfully');
          final stagesData = OrderStagesData.fromJson(data);
          emit(OrderStagesLoaded(stagesData));
        } catch (e) {
          print('❌ [ServiceCubit] Error parsing order stages: $e');
          emit(OrderStagesError('Failed to parse order stages data'));
        }
      },
    );
  }

  /// Accept order
  Future<void> acceptOrder(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'accept_order',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.acceptOrder(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Mark as arrived
  Future<void> markArrived(int deliveryOrderId, {String? notes}) async {
    _callOrderStageAction(
      action: 'arrived',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.markArrived(
        deliveryOrderId: deliveryOrderId,
        notes: notes,
      ),
    );
  }

  /// Verify car
  Future<void> verifyCar(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'car_verified',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.verifyCar(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Start washing
  Future<void> startWashing(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'washing_started',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.startWashing(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Complete washing
  Future<void> completeWashing(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'washing_completed',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.completeWashing(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Start drying
  Future<void> startDrying(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'drying_started',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.startDrying(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Complete drying
  Future<void> completeDrying(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'drying_completed',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.completeDrying(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Complete order
  Future<void> completeOrder(int deliveryOrderId) async {
    _callOrderStageAction(
      action: 'complete_order',
      deliveryOrderId: deliveryOrderId,
      repoCall: () => _serviceRepo.completeOrder(deliveryOrderId: deliveryOrderId),
    );
  }

  /// Helper method to call order stage actions
  Future<void> _callOrderStageAction({
    required String action,
    required int deliveryOrderId,
    required Future<Either<Failure, Map<String, dynamic>>> Function() repoCall,
  }) async {
    print('🔄 [ServiceCubit] $action called for order: $deliveryOrderId');
    emit(OrderStageActionLoading());

    final result = await repoCall();

    result.fold(
      (failure) {
        print('❌ [ServiceCubit] Failed to $action: ${failure.message}');
        emit(OrderStageActionError(action, failure.message));
      },
      (data) {
        print('✅ [ServiceCubit] $action completed successfully');
        emit(OrderStageActionSuccess(action, data: data));
      },
    );
  }

  @override
  Future<void> close() {
    print('🛑 [ServiceCubit] close() called - cleaning up location stream');
    _locationUpdateTimer?.cancel();
    _locationSubscription?.cancel();
    _isStreaming = false;
    _lastLatitude = null;
    _lastLongitude = null;
    return super.close();
  }
}
