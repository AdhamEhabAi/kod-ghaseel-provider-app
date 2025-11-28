part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {
  final String tabType;

  OrdersLoading({required this.tabType});
}

final class OrdersSuccess extends OrdersState {
  final String tabType;
  final OrdersResponse ordersResponse;

  OrdersSuccess({
    required this.tabType,
    required this.ordersResponse,
  });
}

final class OrdersError extends OrdersState {
  final String message;
  final String tabType;

  OrdersError({
    required this.message,
    required this.tabType,
  });
}