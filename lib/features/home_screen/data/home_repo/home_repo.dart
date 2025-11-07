import 'package:dartz/dartz.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/data/models/banner_response_model.dart';

import '../../../../core/app_repository/repo.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/shared_prefrence.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/CheckSessionValidationResponse.dart';

class HomeRepo extends Repository {
  Future<Either<Failure, CheckSessionValidationResponse>>
  checkSessionValidation() {
    return exceptionHandler(() async {
      Map response = await dioHelper
          .postData(APIEndpoints.checkSessionValidation, {
            "action": "validate",
            "session_token": AppSharedPreferences.getString(
              SharedPreferencesKeys.accessToken,
            ),
          });
      var success = response["success"];
      if (success) {
        return CheckSessionValidationResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage: response["message"] ?? "Session is not valid",
        );
      }
    });
  }

  Future<Either<Failure, BannerResponse>> getHomeBanners({
    String targetApp = "providers",
    String displayType = "slider",
  }) {
    return exceptionHandler(() async {
      final response = await dioHelper.postData(APIEndpoints.homeBanners, {
        "action": "get_all",
        "target_app": targetApp,
        "display_type": displayType,
      });

      final success = response["success"] == true;
      if (success) {
        return BannerResponse.fromJson(response);
      } else {
        throw ServerException(
          exceptionMessage:
              response["message"] ?? "Failed to load home banners",
        );
      }
    });
  }
}
