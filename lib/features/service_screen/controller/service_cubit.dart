import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/data/models/order_stages_model.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/data/repo/service_repo.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;

part 'service_state.dart';

@injectable
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
    debugPrint('📍 [ServiceCubit] initializeLocation() called');
    developer.log(
      '📍 [ServiceCubit] initializeLocation() called',
      name: 'Location',
    );
    emit(ServiceLocationLoading());

    try {
      // Check and request location service
      bool serviceEnabled = await _serviceRepo.isLocationServiceEnabled();
      debugPrint('📍 [ServiceCubit] Location service enabled: $serviceEnabled');
      if (!serviceEnabled) {
        serviceEnabled = await _serviceRepo.requestLocationService();
        debugPrint(
          '📍 [ServiceCubit] Location service requested, enabled: $serviceEnabled',
        );
        if (!serviceEnabled) {
          debugPrint('❌ [ServiceCubit] Location service denied');
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
      debugPrint('📍 [ServiceCubit] Location permission status: $permissionStatus');

      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _serviceRepo.requestLocationPermission();
        debugPrint(
          '📍 [ServiceCubit] Location permission requested, status: $permissionStatus',
        );
      }

      // For Android, also request background location permission
      if (Platform.isAndroid) {
        if (permissionStatus == PermissionStatus.granted) {
          // Request background location permission for Android 10+
          final backgroundPermission = await Permission.locationAlways.status;
          debugPrint(
            '📍 [ServiceCubit] Background location permission status: $backgroundPermission',
          );
          if (backgroundPermission.isDenied) {
            await Permission.locationAlways.request();
            debugPrint('📍 [ServiceCubit] Background location permission requested');
          }
        }
      }

      if (permissionStatus != PermissionStatus.granted) {
        debugPrint('❌ [ServiceCubit] Location permission not granted');
        emit(
          ServiceLocationPermissionDenied(
            'Location permission is required to track your position.',
          ),
        );
        return;
      }

      // Configure location settings for background tracking
      bool configured = await _serviceRepo.configureLocationSettings();
      debugPrint('📍 [ServiceCubit] Location settings configured: $configured');
      if (!configured) {
        emit(ServiceLocationError('Failed to configure location settings.'));
        return;
      }

      // Get initial location
      final locationData = await _serviceRepo.getCurrentLocation();
      if (locationData != null) {
        debugPrint(
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
        debugPrint('❌ [ServiceCubit] Unable to get current location');
        emit(ServiceLocationError('Unable to get current location.'));
      }
    } catch (e) {
      debugPrint('❌ [ServiceCubit] Error initializing location: $e');
      emit(
        ServiceLocationError('Error initializing location: ${e.toString()}'),
      );
    }
  }

  /// Start location streaming (works in background)
  Future<void> startLocationStream() async {
    if (_isStreaming) {
      debugPrint('📍 [ServiceCubit] Location stream already active');
      return; // Already streaming
    }

    debugPrint('📍 [ServiceCubit] startLocationStream() called');

    try {
      // Ensure permissions are granted
      PermissionStatus permissionStatus = await _serviceRepo
          .getLocationPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        debugPrint('📍 [ServiceCubit] Permission not granted, initializing...');
        await initializeLocation();
        permissionStatus = await _serviceRepo.getLocationPermissionStatus();
        if (permissionStatus != PermissionStatus.granted) {
          debugPrint(
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
            debugPrint(
              '⚠️ [ServiceCubit] Location data received but lat/lng is null',
            );
          }
        },
        onError: (error) {
          debugPrint('❌ [ServiceCubit] Location stream error: $error');
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
      debugPrint('✅ [ServiceCubit] Location stream started successfully');
      developer.log('✅ Location stream started', name: 'Location');
    } catch (e) {
      debugPrint('❌ [ServiceCubit] Error starting location stream: $e');
      emit(
        ServiceLocationError('Error starting location stream: ${e.toString()}'),
      );
    }
  }

  void _startLocationUpdateTimer() {
    _locationUpdateTimer?.cancel();
    debugPrint(
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
        debugPrint(
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
          debugPrint(
            '❌ [ServiceCubit] Failed to update location on server: ${failure.message}',
          );
        },
        (data) {
          debugPrint('✅ [ServiceCubit] Location updated on server successfully');
        },
      );
    } catch (e) {
      debugPrint('❌ [ServiceCubit] Error updating location on server: $e');
    }
  }

  /// Stop location streaming
  Future<void> stopLocationStream() async {
    debugPrint('🛑 [ServiceCubit] stopLocationStream() called');

    // Cancel location update timer
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;

    await _locationSubscription?.cancel();
    _locationSubscription = null;
    _isStreaming = false;
    _lastLatitude = null;
    _lastLongitude = null;

    debugPrint('✅ [ServiceCubit] Location stream stopped');
    emit(ServiceInitial());
  }

  Future<void> getCurrentLocation() async {
    debugPrint('📍 [ServiceCubit] getCurrentLocation() called');
    emit(ServiceLocationLoading());

    try {
      // Check permissions
      PermissionStatus permissionStatus = await _serviceRepo
          .getLocationPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        await initializeLocation();
        permissionStatus = await _serviceRepo.getLocationPermissionStatus();
        if (permissionStatus != PermissionStatus.granted) {
          debugPrint(
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
        debugPrint(
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
        debugPrint('❌ [ServiceCubit] Unable to get current location');
        emit(ServiceLocationError('Unable to get current location.'));
      }
    } catch (e) {
      debugPrint('❌ [ServiceCubit] Error getting location: $e');
      emit(ServiceLocationError('Error getting location: ${e.toString()}'));
    }
  }

  /// Get order stages
  Future<void> getOrderStages(int deliveryOrderId) async {
    debugPrint('📋 [ServiceCubit] getOrderStages() called for order: $deliveryOrderId');
    emit(OrderStagesLoading());

    final result = await _serviceRepo.getOrderStages(
      deliveryOrderId: deliveryOrderId,
    );

    result.fold(
      (failure) {
        debugPrint('❌ [ServiceCubit] Failed to get order stages: ${failure.message}');
        emit(OrderStagesError(failure.message));
      },
      (data) {
        try {
          debugPrint('✅ [ServiceCubit] Order stages loaded successfully');
          final stagesData = OrderStagesData.fromJson(data);
          emit(OrderStagesLoaded(stagesData));
        } catch (e) {
          debugPrint('❌ [ServiceCubit] Error parsing order stages: $e');
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
    debugPrint('🔄 [ServiceCubit] $action called for order: $deliveryOrderId');
    emit(OrderStageActionLoading());

    final result = await repoCall();

    result.fold(
      (failure) {
        debugPrint('❌ [ServiceCubit] Failed to $action: ${failure.message}');
        emit(OrderStageActionError(action, failure.message));
      },
      (data) {
        debugPrint('✅ [ServiceCubit] $action completed successfully');
        emit(OrderStageActionSuccess(action, data: data));
      },
    );
  }

  @override
  Future<void> close() {
    debugPrint('🛑 [ServiceCubit] close() called - cleaning up location stream');
    _locationUpdateTimer?.cancel();
    _locationSubscription?.cancel();
    _isStreaming = false;
    _lastLatitude = null;
    _lastLongitude = null;
    return super.close();
  }
}
