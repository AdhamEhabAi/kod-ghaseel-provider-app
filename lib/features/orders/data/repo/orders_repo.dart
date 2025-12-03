import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/app_repository/repo.dart';
import 'package:kod_ghaseel_provider_app/core/errors/exceptions.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';

// Top-level function for isolate (must be top-level to work with compute)
OrdersResponse _parseOrdersResponse(Map<String, dynamic> json) {
  return OrdersResponse.fromJson(json);
}

@injectable
class OrdersRepo extends Repository {
  Future<Either<Failure, OrdersResponse>> getOrders({
    required String filter,
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> requestData = <String, dynamic>{
        'action': 'get_orders',
        'session_token': AppSharedPreferences.getString(
          SharedPreferencesKeys.accessToken,
        ),
        'filter': filter,
        'limit': limit,
        'offset': offset,
      };

      if (status != null) {
        requestData['status'] = status;
      }

      final Map<String, dynamic> response = await dioHelper.postData(
        APIEndpoints.login,
        requestData,
      );

      final bool success = response['success'] ?? false;

      if (success) {
        final ordersResponse = await compute(_parseOrdersResponse, response);
        return ordersResponse;
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'فشل في جلب الطلبات',
        );
      }
    });
  }
}