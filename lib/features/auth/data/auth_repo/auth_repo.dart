import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/app_repository/repo.dart';
import 'package:kod_ghaseel_provider_app/core/errors/exceptions.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/api_endpoints.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/models/login_response.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/models/request_pin_response.dart';

import '../../../home_screen/data/models/update_fcm_token.dart';

@injectable
class AuthRepo extends Repository {
  Future<Either<Failure, LoginResponse>> loginByMobile({
    required String mobile,
    required String pinCode,
    required String deviceId,
    required String deviceType,
  }) async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> response = await dioHelper
          .postData(APIEndpoints.login, <String, dynamic>{
            'action': 'login',
            'phone': mobile,
            'pin_code': pinCode,
            'device_id': deviceId,
            'device_type': deviceType,
          });
      final bool success = response['success'] ?? false;

      if (success) {
        final loginResponse = LoginResponse.fromJson(response);
        return loginResponse;
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Login failed',
        );
      }
    });
  }

  Future<Either<Failure, RequestPinResponse>> sendPinCode({
    required String mobile,
    required String deviceId,
    required String deviceType,
  }) async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> response = await dioHelper
          .postData(APIEndpoints.login, <String, dynamic>{
            'action': 'request_login',
            'phone': mobile,
            'device_id': deviceId,
            'device_type': deviceType,
          });

      final bool success = response['success'] ?? false;

      if (success) {
        final requestPinResponse = RequestPinResponse.fromJson(response);
        return requestPinResponse;
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'فشل في إرسال الرمز',
        );
      }
    });
  }
  Future<Either<Failure, RequestPinResponse>> reSendPinCode({
    required String mobile,
  }) async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> response = await dioHelper.postData(
        APIEndpoints.login,
        <String, dynamic>{'action': 'resend_login_pin', 'phone': mobile},
      );

      final bool success = response['success'] ?? false;

      if (success) {
        final requestPinResponse = RequestPinResponse.fromJson(response);
        return requestPinResponse;
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'فشل في إرسال الرمز',
        );
      }
    });
  }

  Future<Either<Failure, UpdateFcmTokenResponse>> updateFcmToken({
    required String token,
  }) {
    return exceptionHandler(() async {
      final response = await dioHelper.postData(APIEndpoints.login, {
        "action": "update_fcm",
        "session_token": AppSharedPreferences.getString(
          SharedPreferencesKeys.accessToken,),
        "fcm_token": token,
      });

      final success = response["success"] == true;
      if (success) {
        print("fcm token is :${response["data"]}");
        return UpdateFcmTokenResponse.fromJson(response);
      } else {
        print("fcm token message is :${response["message"]}");
        throw ServerException(
          exceptionMessage: response["message"] ?? "Failed to save fcm token",
        );
      }
    });
  }


  Future<Either<Failure, String>> logout() async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> response = await dioHelper
          .postData(APIEndpoints.login, <String, dynamic>{
            'action': 'logout',
            'session_token': AppSharedPreferences.getString(
              SharedPreferencesKeys.accessToken,
            ),
          });

      final bool success = response['success'] ?? false;

      if (success) {
        return 'Success';
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'فشل في إرسال الرمز',
        );
      }
    });
  }
}
