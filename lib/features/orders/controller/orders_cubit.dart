import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/repo/orders_repo.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

enum OrderTabType {
  upcoming,
  current,
  past,
}

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo _ordersRepo;

  OrdersCubit(this._ordersRepo) : super(OrdersInitial());

  // Store orders by tab type
  OrdersResponse? upcomingOrders;
  OrdersResponse? currentOrders;
  OrdersResponse? pastOrders;

  Future<void> getOrders({
    required OrderTabType tabType,
    int limit = 5,
    int offset = 0,
  }) async {
    emit(OrdersLoading(tabType: tabType.name));

    String filter;
    String? status;

    switch (tabType) {
      case OrderTabType.upcoming:
        filter = 'upcoming';
        break;
      case OrderTabType.current:
        filter = 'today';
        break;
      case OrderTabType.past:
        filter = 'past';
        break;
    }

    final result = await _ordersRepo.getOrders(
      filter: filter,
      status: status,
      limit: limit,
      offset: offset,
    );

    result.fold(
      (Failure failure) => emit(OrdersError(
        message: failure.message,
        tabType: tabType.name,
      )),
      (OrdersResponse response) {
        // Store orders by tab type
        switch (tabType) {
          case OrderTabType.upcoming:
            upcomingOrders = response;
            break;
          case OrderTabType.current:
            currentOrders = response;
            break;
          case OrderTabType.past:
            pastOrders = response;
            break;
        }

        emit(OrdersSuccess(
          tabType: tabType.name,
          ordersResponse: response,
        ));
      },
    );
  }

  OrdersResponse? getOrdersByTabType(OrderTabType tabType) {
    switch (tabType) {
      case OrderTabType.upcoming:
        return upcomingOrders;
      case OrderTabType.current:
        return currentOrders;
      case OrderTabType.past:
        return pastOrders;
    }
  }
}
