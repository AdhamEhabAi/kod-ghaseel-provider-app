import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/app_repository/repo.dart';
import 'package:kod_ghaseel_provider_app/core/errors/exceptions.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:kod_ghaseel_provider_app/features/statics/data/models/statistics_response.dart';

// Top-level function for isolate (must be top-level to work with compute)
StatisticsResponse _parseStatisticsResponse(Map<String, dynamic> json) {
  return StatisticsResponse.fromJson(json);
}

@injectable
class StaticsRepo extends Repository {
  Future<Either<Failure, StatisticsResponse>> getStatistics() async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> requestData = <String, dynamic>{
        'action': 'get_statistics',
        'session_token': AppSharedPreferences.getString(
          SharedPreferencesKeys.accessToken,
        ),
      };

      final Map<String, dynamic> response = await dioHelper.postData(
        APIEndpoints.login,
        requestData,
      );

      final bool success = response['success'] ?? false;

      if (success) {
        final statisticsResponse =
            await compute(_parseStatisticsResponse, response);
        return statisticsResponse;
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'فشل في جلب الإحصائيات',
        );
      }
    });
  }
}