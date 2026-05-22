import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
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

  // ─────────────────────────────────────────────────────────────────────────
  // PERMISSION FLOW — App Store Compliant
  //
  // Step 1 (Home Screen, after login):
  //   Call initializeLocation() → requests "When In Use" permission only.
  //   The system dialog is shown AFTER the app's own rationale dialog
  //   (LocationPermissionDialog) is accepted by the user.
  //
  // Step 2 (Service Screen, when provider starts an active job):
  //   Call requestBackgroundLocationForJob() → requests "Always" permission.
  //   This is only called in the context where background tracking is needed,
  //   which satisfies both Apple Guideline 5.1.1 and Google Play policy.
  // ─────────────────────────────────────────────────────────────────────────

  /// Initialises location for "When In Use" only.
  /// Called from HomeScreen AFTER the app's own rationale dialog is accepted.
  /// Does NOT request background/always location — that comes later at job start.
  Future<void> initializeLocation() async {
    debugPrint('📍 [ServiceCubit] initializeLocation() — foreground only');
    emit(ServiceLocationLoading());

    try {
      // 1. Ensure location service is on
      bool serviceEnabled = await _serviceRepo.isLocationServiceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _serviceRepo.requestLocationService();
        if (!serviceEnabled) {
          emit(ServiceLocationPermissionDenied(
            'Location services are disabled. Please enable them in device settings.',
          ));
          return;
        }
      }

      // 2. Check foreground permission status.
      //    initializeLocation() never requests permission — that is exclusively
      //    the caller's responsibility (HomeScreen handles the full dialog flow).
      //    If permission is not granted here, it means the caller did not obtain
      //    it first; fail gracefully rather than popping an unexpected OS dialog.
      final PermissionStatus permissionStatus =
          await _serviceRepo.getLocationPermissionStatus();

      if (permissionStatus != PermissionStatus.granted) {
        emit(ServiceLocationPermissionDenied(
          'Location permission is required to receive service jobs.',
        ));
        return;
      }

      // 4. Configure location settings (accuracy, interval, distance filter)
      final configured = await _serviceRepo.configureLocationSettings();
      if (!configured) {
        emit(ServiceLocationError('Failed to configure location settings.'));
        return;
      }

      // 5. Get initial position
      final locationData = await _serviceRepo.getCurrentLocation();
      if (locationData != null &&
          locationData.latitude != null &&
          locationData.longitude != null) {
        _lastLatitude = locationData.latitude;
        _lastLongitude = locationData.longitude;
        emit(ServiceLocationEnabled(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          accuracy: locationData.accuracy,
          altitude: locationData.altitude,
          speed: locationData.speed,
          timestamp: DateTime.now(),
        ));
      } else {
        emit(ServiceLocationError('Unable to get current location.'));
      }
    } catch (e) {
      debugPrint('❌ [ServiceCubit] initializeLocation error: $e');
      emit(ServiceLocationError('Error initialising location: ${e.toString()}'));
    }
  }

  /// Requests background (Always) location permission immediately before
  /// starting an active service job. Must only be called:
  ///  - When foreground location is already granted
  ///  - When the provider explicitly presses "Start Job"
  ///  - On Android only (iOS background mode is declared in Info.plist and
  ///    granted as part of the "Always" permission flow automatically)
  ///
  /// Returns true if background permission is granted or already available.
  Future<bool> requestBackgroundLocationForJob() async {
    if (!Platform.isAndroid) return true;

    final foregroundStatus = await _serviceRepo.getLocationPermissionStatus();
    if (foregroundStatus != PermissionStatus.granted) {
      debugPrint('❌ [ServiceCubit] Cannot request background location — foreground not granted');
      return false;
    }

    final backgroundStatus = await Permission.locationAlways.status;
    if (backgroundStatus.isGranted) return true;

    // On Android, the system will only show the "Allow all the time" option
    // in device settings after foreground is granted. We open settings directly
    // because Android 11+ does not allow showing the permission dialog for
    // background location inline — it must go through settings.
    if (Platform.isAndroid) {
      final result = await Permission.locationAlways.request();
      return result.isGranted;
    }

    return false;
  }

  /// Starts the live location stream and periodic server updates.
  /// Called when a service job begins. Optionally attempts background permission
  /// if [requestBackground] is true (default).
  Future<void> startLocationStream({bool requestBackground = true}) async {
    if (_isStreaming) return;

    debugPrint('📍 [ServiceCubit] startLocationStream()');

    try {
      final PermissionStatus permissionStatus =
          await _serviceRepo.getLocationPermissionStatus();

      if (permissionStatus != PermissionStatus.granted) {
        emit(ServiceLocationPermissionDenied(
          'Location permission is required to track your position.',
        ));
        return;
      }

      await _serviceRepo.configureLocationSettings();

      _locationSubscription = _serviceRepo.getLocationStream().listen(
        (LocationData locationData) {
          if (locationData.latitude != null && locationData.longitude != null) {
            _lastLatitude = locationData.latitude;
            _lastLongitude = locationData.longitude;

            if (kDebugMode) {
              developer.log(
                '📍 Location — Lat: ${locationData.latitude}, '
                'Lng: ${locationData.longitude}, '
                'Accuracy: ${locationData.accuracy}m',
                name: 'Location',
              );
            }

            emit(ServiceLocationStreamActive(
              latitude: locationData.latitude!,
              longitude: locationData.longitude!,
              accuracy: locationData.accuracy,
              altitude: locationData.altitude,
              speed: locationData.speed,
              timestamp: DateTime.now(),
            ));
          }
        },
        onError: (error) {
          debugPrint('❌ [ServiceCubit] Location stream error: $error');
          emit(ServiceLocationError('Location stream error: ${error.toString()}'));
        },
        cancelOnError: false,
      );

      _startLocationUpdateTimer();
      _isStreaming = true;
      debugPrint('✅ [ServiceCubit] Location stream started');
    } catch (e) {
      debugPrint('❌ [ServiceCubit] startLocationStream error: $e');
      emit(ServiceLocationError('Error starting location stream: ${e.toString()}'));
    }
  }

  void _startLocationUpdateTimer() {
    _locationUpdateTimer?.cancel();
    // Send initial update immediately
    if (_lastLatitude != null && _lastLongitude != null) {
      _updateLocationOnServer(_lastLatitude!, _lastLongitude!);
    }
    // Then every 30 seconds
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_lastLatitude != null && _lastLongitude != null && _isStreaming) {
        _updateLocationOnServer(_lastLatitude!, _lastLongitude!);
      }
    });
  }

  Future<void> _updateLocationOnServer(double latitude, double longitude) async {
    try {
      final result = await _serviceRepo.updateDeliveryLocation(
        latitude: latitude,
        longitude: longitude,
      );
      result.fold(
        (failure) => debugPrint(
            '❌ [ServiceCubit] Location server update failed: ${failure.message}'),
        (_) => debugPrint('✅ [ServiceCubit] Location updated on server'),
      );
    } catch (e) {
      debugPrint('❌ [ServiceCubit] Location server update error: $e');
    }
  }

  Future<void> stopLocationStream() async {
    debugPrint('🛑 [ServiceCubit] stopLocationStream()');
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;
    await _locationSubscription?.cancel();
    _locationSubscription = null;
    _isStreaming = false;
    _lastLatitude = null;
    _lastLongitude = null;
    emit(ServiceInitial());
  }

  Future<void> getCurrentLocation() async {
    emit(ServiceLocationLoading());
    try {
      final PermissionStatus permissionStatus =
          await _serviceRepo.getLocationPermissionStatus();
      if (permissionStatus != PermissionStatus.granted) {
        emit(ServiceLocationPermissionDenied('Location permission is required.'));
        return;
      }

      final locationData = await _serviceRepo.getCurrentLocation();
      if (locationData != null &&
          locationData.latitude != null &&
          locationData.longitude != null) {
        emit(ServiceLocationEnabled(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          accuracy: locationData.accuracy,
          altitude: locationData.altitude,
          speed: locationData.speed,
          timestamp: DateTime.now(),
        ));
      } else {
        emit(ServiceLocationError('Unable to get current location.'));
      }
    } catch (e) {
      emit(ServiceLocationError('Error getting location: ${e.toString()}'));
    }
  }

  // ── Order stage actions ──────────────────────────────────────────────────

  Future<void> getOrderStages(int deliveryOrderId) async {
    emit(OrderStagesLoading());
    final result = await _serviceRepo.getOrderStages(
        deliveryOrderId: deliveryOrderId);
    result.fold(
      (failure) => emit(OrderStagesError(failure.message)),
      (data) {
        try {
          emit(OrderStagesLoaded(OrderStagesData.fromJson(data)));
        } catch (e) {
          emit(OrderStagesError('Failed to parse order stages data'));
        }
      },
    );
  }

  Future<void> acceptOrder(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'accept_order',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.acceptOrder(deliveryOrderId: deliveryOrderId),
      );

  Future<void> markArrived(int deliveryOrderId, {String? notes}) =>
      _callOrderStageAction(
        action: 'arrived',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.markArrived(deliveryOrderId: deliveryOrderId, notes: notes),
      );

  Future<void> verifyCar(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'car_verified',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.verifyCar(deliveryOrderId: deliveryOrderId),
      );

  Future<void> startWashing(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'washing_started',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.startWashing(deliveryOrderId: deliveryOrderId),
      );

  Future<void> completeWashing(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'washing_completed',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.completeWashing(deliveryOrderId: deliveryOrderId),
      );

  Future<void> startDrying(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'drying_started',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.startDrying(deliveryOrderId: deliveryOrderId),
      );

  Future<void> completeDrying(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'drying_completed',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.completeDrying(deliveryOrderId: deliveryOrderId),
      );

  Future<void> completeOrder(int deliveryOrderId) =>
      _callOrderStageAction(
        action: 'complete_order',
        deliveryOrderId: deliveryOrderId,
        repoCall: () =>
            _serviceRepo.completeOrder(deliveryOrderId: deliveryOrderId),
      );

  Future<void> _callOrderStageAction({
    required String action,
    required int deliveryOrderId,
    required Future<Either<Failure, Map<String, dynamic>>> Function() repoCall,
  }) async {
    emit(OrderStageActionLoading());
    final result = await repoCall();
    result.fold(
      (failure) => emit(OrderStageActionError(action, failure.message)),
      (data) => emit(OrderStageActionSuccess(action, data: data)),
    );
  }

  @override
  Future<void> close() {
    _locationUpdateTimer?.cancel();
    _locationSubscription?.cancel();
    _isStreaming = false;
    return super.close();
  }
}
