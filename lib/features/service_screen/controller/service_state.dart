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

final class OrderStagesLoading extends ServiceState {}

final class OrderStagesLoaded extends ServiceState {
  final OrderStagesData stagesData;
  
  OrderStagesLoaded(this.stagesData);
}

final class OrderStagesError extends ServiceState {
  final String message;
  OrderStagesError(this.message);
}

final class OrderStageActionLoading extends ServiceState {}

final class OrderStageActionSuccess extends ServiceState {
  final String action;
  final Map<String, dynamic>? data;
  OrderStageActionSuccess(this.action, {this.data});
}

final class OrderStageActionError extends ServiceState {
  final String action;
  final String message;
  OrderStageActionError(this.action, this.message);
}