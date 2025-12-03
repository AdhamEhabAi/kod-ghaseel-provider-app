import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/app_repository/repo.dart';
import 'package:kod_ghaseel_provider_app/core/errors/exceptions.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:location/location.dart';

@injectable
class ServiceRepo extends Repository {
  final Location _location = Location();

  /// Check if location service is enabled
  Future<bool> isLocationServiceEnabled() async {
    return await _location.serviceEnabled();
  }

  /// Request location service to be enabled
  Future<bool> requestLocationService() async {
    return await _location.requestService();
  }

  /// Check location permission status
  Future<PermissionStatus> getLocationPermissionStatus() async {
    return await _location.hasPermission();
  }

  /// Request location permissions
  Future<PermissionStatus> requestLocationPermission() async {
    return await _location.requestPermission();
  }

  /// Get current location
  Future<LocationData?> getCurrentLocation() async {
    try {
      return await _location.getLocation();
    } catch (e) {
      return null;
    }
  }

  /// Configure location settings for background tracking
  Future<bool> configureLocationSettings() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return false;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return false;
        }
      }

      // Configure location settings for background tracking
      await _location.changeSettings(
        accuracy: LocationAccuracy.high,
        interval: 5000, // 5 seconds
        distanceFilter: 10, // 10 meters
      );

      // Try to enable background mode (if supported by the package)
      try {
        await _location.enableBackgroundMode(enable: true);
      } catch (e) {
        // Background mode might not be available in all versions
        // The stream will still work with proper permissions
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get location stream
  Stream<LocationData> getLocationStream() {
    return _location.onLocationChanged;
  }

  /// Update delivery location on server
  Future<Either<Failure, Map<String, dynamic>>> updateDeliveryLocation({
    required double latitude,
    required double longitude,
  }) async {
    return await exceptionHandler(() async {
      final sessionToken = AppSharedPreferences.getString(
        SharedPreferencesKeys.accessToken,
      );

      if (sessionToken == null || sessionToken.isEmpty) {
        throw ServerException(
          exceptionMessage: 'Session token not found',
        );
      }

      final Map<String, dynamic> requestData = <String, dynamic>{
        'action': 'update_location',
        'session_token': sessionToken,
        'latitude': latitude,
        'longitude': longitude,
      };

      final Map<String, dynamic> response = await dioHelper.postData(
        APIEndpoints.login,
        requestData,
      );

      final bool success = response['success'] ?? false;

      if (success) {
        return response['data'] as Map<String, dynamic>;
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Failed to update location',
        );
      }
    });
  }

  /// Get order stages
  Future<Either<Failure, Map<String, dynamic>>> getOrderStages({
    required int deliveryOrderId,
  }) async {
    return await exceptionHandler(() async {
      final sessionToken = AppSharedPreferences.getString(
        SharedPreferencesKeys.accessToken,
      );

      if (sessionToken == null || sessionToken.isEmpty) {
        throw ServerException(
          exceptionMessage: 'Session token not found',
        );
      }

      final Map<String, dynamic> requestData = <String, dynamic>{
        'action': 'get_order_stages',
        'session_token': sessionToken,
        'delivery_order_id': deliveryOrderId,
      };

      final dynamic response = await dioHelper.postData(
        APIEndpoints.login,
        requestData,
      );

      if (response == null) {
        print('❌ [ServiceRepo] getOrderStages: Response is null');
        throw ServerException(
          exceptionMessage: 'No response from server',
        );
      }

      print('📥 [ServiceRepo] getOrderStages response type: ${response.runtimeType}');
      print('📥 [ServiceRepo] getOrderStages response: $response');

      if (response is! Map<String, dynamic>) {
        print('❌ [ServiceRepo] getOrderStages: Response is not a Map');
        throw ServerException(
          exceptionMessage: 'Invalid response format from server: ${response.runtimeType}',
        );
      }

      final bool success = response['success'] ?? false;

      if (success) {
        final data = response['data'];
        if (data == null) {
          print('⚠️ [ServiceRepo] getOrderStages: Success but data is null, returning empty map');
          // Return empty map if no data
          return <String, dynamic>{};
        }
        if (data is Map<String, dynamic>) {
          return data;
        }
        // If data is not a map, wrap it
        print('⚠️ [ServiceRepo] getOrderStages: Data is not a Map, wrapping it');
        return {'data': data};
      } else {
        final errorMessage = response['message'] ?? 'Failed to get order stages';
        print('❌ [ServiceRepo] getOrderStages failed: $errorMessage');
        throw ServerException(
          exceptionMessage: errorMessage,
        );
      }
    });
  }

  /// Accept order
  Future<Either<Failure, Map<String, dynamic>>> acceptOrder({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'accept_order',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Mark as arrived
  Future<Either<Failure, Map<String, dynamic>>> markArrived({
    required int deliveryOrderId,
    String? notes,
  }) async {
    return _callOrderStageAction(
      action: 'arrived',
      deliveryOrderId: deliveryOrderId,
      notes: notes,
    );
  }

  /// Verify car
  Future<Either<Failure, Map<String, dynamic>>> verifyCar({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'car_verified',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Start washing
  Future<Either<Failure, Map<String, dynamic>>> startWashing({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'washing_started',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Complete washing
  Future<Either<Failure, Map<String, dynamic>>> completeWashing({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'washing_completed',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Start drying
  Future<Either<Failure, Map<String, dynamic>>> startDrying({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'drying_started',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Complete drying
  Future<Either<Failure, Map<String, dynamic>>> completeDrying({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'drying_completed',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Complete order
  Future<Either<Failure, Map<String, dynamic>>> completeOrder({
    required int deliveryOrderId,
  }) async {
    return _callOrderStageAction(
      action: 'complete_order',
      deliveryOrderId: deliveryOrderId,
    );
  }

  /// Helper method to call order stage actions
  Future<Either<Failure, Map<String, dynamic>>> _callOrderStageAction({
    required String action,
    required int deliveryOrderId,
    String? notes,
  }) async {
    return await exceptionHandler(() async {
      final sessionToken = AppSharedPreferences.getString(
        SharedPreferencesKeys.accessToken,
      );

      if (sessionToken == null || sessionToken.isEmpty) {
        throw ServerException(
          exceptionMessage: 'Session token not found',
        );
      }

      final Map<String, dynamic> requestData = <String, dynamic>{
        'action': action,
        'session_token': sessionToken,
        'delivery_order_id': deliveryOrderId,
      };

      if (notes != null && notes.isNotEmpty) {
        requestData['notes'] = notes;
      }

      final dynamic response = await dioHelper.postData(
        APIEndpoints.login,
        requestData,
      );

      if (response == null) {
        throw ServerException(
          exceptionMessage: 'No response from server',
        );
      }

      if (response is! Map<String, dynamic>) {
        throw ServerException(
          exceptionMessage: 'Invalid response format from server',
        );
      }

      final bool success = response['success'] ?? false;

      if (success) {
        final data = response['data'];
        if (data == null) {
          return <String, dynamic>{};
        }
        if (data is Map<String, dynamic>) {
          return data;
        }
        // If data is not a map, wrap it
        return {'data': data};
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Failed to $action',
        );
      }
    });
  }
}