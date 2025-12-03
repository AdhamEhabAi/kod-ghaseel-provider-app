import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/app_repository/repo.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helpers/shared_prefrence.dart';
import '../../../../../../core/network/api_endpoints.dart';
import '../../../../../auth/data/models/login_response.dart';
import '../models/RequestUpdatePhoneNumberResponse.dart';
import '../models/VerifyChangePhoneResponse.dart';
import '../models/update_profile_response.dart' hide User;

@injectable
class ProfileRepo extends Repository {
  Future<Either<Failure, UpdateProfileResponse>> updateProfileData({
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String city,
    required String address,
    required String profileImage,
    required String vehicleType,
    required String vehiclePlate,
    required String licenseNumber,
  }) async {
    return await exceptionHandler(() async {
      final Map<String, dynamic> response = await dioHelper.postData(
        APIEndpoints.updateProfileEndPoint,
        {
          "action": "update_profile",
          "session_token": AppSharedPreferences.getString(
            SharedPreferencesKeys.accessToken,
          ),
          "profile_data": {
            "full_name": fullName,
            "date_of_birth": dateOfBirth,
            "gender": gender,
            "city": city,
            "address": address,
            "profile_image": profileImage,
            "vehicle_type": vehicleType,
            "vehicle_plate": vehiclePlate,
            "license_number": licenseNumber,
          },
        },
      );

      final bool success = response['success'] ?? false;

      if (success) {
        return UpdateProfileResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Update profile failed',
        );
      }
    });
  }

  Future<Either<Failure, RequestUpdatePhoneNumberResponse>> updatePhoneNumberRequest({
    required String phoneNumber
  }) async {
    return await exceptionHandler(() async {
      var user=User.fromJson(jsonDecode(AppSharedPreferences.getString(SharedPreferencesKeys.userModel)?? "error"));
      final Map<String, dynamic> response = await dioHelper.postData(
          APIEndpoints.updatePhoneNumberRequestEndPoint,
          {
            "action": "request_phone_change",
            "user_id": user.id,
            "new_phone": phoneNumber
          }
      );
      final bool success = response['success'] ?? false;

      if (success) {
        return RequestUpdatePhoneNumberResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Login failed',
        );
      }
    });
  }
  Future<Either<Failure, VerifyChangePhoneResponse>> verifyPhoneWithOtp({
    required String otp
  }) async {
    return await exceptionHandler(() async {
      var user=User.fromJson(jsonDecode(AppSharedPreferences.getString(SharedPreferencesKeys.userModel)?? "error"));
      final Map<String, dynamic> response = await dioHelper.postData(
          APIEndpoints.verifyChangePhoneNumberWithOtp,
          {
            "action": "verify_phone_change",
            "user_id": user.id,
            "pin_code": otp
          }
      );
      final bool success = response['success'] ?? false;

      if (success) {
        return VerifyChangePhoneResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Login failed',
        );
      }
    });
  }

}
