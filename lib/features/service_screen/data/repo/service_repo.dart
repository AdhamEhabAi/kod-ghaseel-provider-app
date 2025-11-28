import 'package:kod_ghaseel_provider_app/core/app_repository/repo.dart';
import 'package:location/location.dart';

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
}