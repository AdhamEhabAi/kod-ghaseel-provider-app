import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/features/notification/data/models/get_all_notification_response.dart';

import '../../../../core/app_repository/repo.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/shared_prefrence.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/delete_notification_response.dart';
import '../models/mark_as_read_response.dart';

@injectable
class NotificationRepo extends Repository {
  Future<Either<Failure, GetAllNotificationsResponse>> getNotifications() {
    return exceptionHandler(() async {
      final response = await dioHelper.postData(
        APIEndpoints.notificationEndpoint,
        {
          "action": "get_notifications",
          "session_token":AppSharedPreferences.getString(SharedPreferencesKeys.accessToken),
          "include_read": true,
        },
      );
      if (response["success"] == true) {
        return GetAllNotificationsResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage:
          response["message"] ?? "Failed to load optional services",
        );
      }
    });
  }

  Future<Either<Failure, DeleteNotificationResponse>> deleteNotification({
    required int notificationId
  }) {
    return exceptionHandler(() async {
      final response = await dioHelper.postData(
        APIEndpoints.notificationEndpoint,
        {
          "action": "delete_notification",
          "session_token":AppSharedPreferences.getString(SharedPreferencesKeys.accessToken),
          "notification_id": notificationId
        },
      );
      if (response["success"] == true) {
        return DeleteNotificationResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage:
          response["message"] ?? "Failed to load optional services",
        );
      }
    });
  } Future<Either<Failure, MarkAsReadResponse>> markAsRead({
    required int notificationId
  }) {
    return exceptionHandler(() async {
      final response = await dioHelper.postData(
        APIEndpoints.notificationEndpoint,
        {
          "action": "mark_notification_read",
          "session_token": AppSharedPreferences.getString(SharedPreferencesKeys.accessToken),
          "notification_id": notificationId
        },
      );
      if (response["success"] == true) {
        return MarkAsReadResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage:
          response["message"] ?? "Failed to load optional services",
        );
      }
    });
  }
}
