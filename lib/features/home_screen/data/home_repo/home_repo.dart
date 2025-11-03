import 'package:dartz/dartz.dart';

import '../../../../core/app_repository/repo.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/helpers/shared_prefrence.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/CheckSessionValidationResponse.dart';

class HomeRepo extends Repository{
  Future<Either<Failure,CheckSessionValidationResponse>> checkSessionValidation(){
    return exceptionHandler(()async {
      Map response= await dioHelper.postData(APIEndpoints.checkSessionValidation, {
        "action": "validate",
        "session_token": AppSharedPreferences.getString(SharedPreferencesKeys.accessToken)
      });
      var success=response["success"];
      if(success){
        return CheckSessionValidationResponse.fromJson(response);
      }else{
        throw ServerException(
          exceptionMessage: response["message"] ?? "Session is not valid"
        );
      }
    },);
  }
}