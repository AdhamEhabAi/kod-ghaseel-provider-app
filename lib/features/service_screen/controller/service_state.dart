part of 'service_cubit.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class ServiceLocationLoading extends ServiceState {}

final class ServiceLocationPermissionDenied extends ServiceState {
  final String message;
  ServiceLocationPermissionDenied(this.message);
}

final class ServiceLocationEnabled extends ServiceState {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? speed;
  final DateTime timestamp;
  
  ServiceLocationEnabled({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    required this.timestamp,
  });
}

final class ServiceLocationError extends ServiceState {
  final String message;
  ServiceLocationError(this.message);
}

final class ServiceLocationStreamActive extends ServiceState {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final double? altitude;
  final double? speed;
  final DateTime timestamp;
  
  ServiceLocationStreamActive({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    required this.timestamp,
  });
}