import 'package:dartz/dartz.dart';

import '../../../../../../core/app_repository/repo.dart';
import '../../../../../../core/errors/exceptions.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/helpers/shared_prefrence.dart';
import '../../../../../../core/network/api_endpoints.dart';
import '../models/update_profile_response.dart';

class ProfileRepo extends Repository {
  Future<Either<Failure, UpdateProfileResponse>> updateProfileData({
    required String fullName,
    required String dateOfBirth,
    required String gender,
    required String city,
    required String address,
    required String profileImage,
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
          },
        },
      );
      final bool success = response['success'] ?? false;

      if (success) {
        return UpdateProfileResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage: response['message'] ?? 'Login failed',
        );
      }
    });
  }
}
