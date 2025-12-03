import 'package:kod_ghaseel_provider_app/features/home_screen/data/models/CheckSessionValidationResponse.dart';

class UpdateProfileResponse {
  final bool success;
  final String message;
  final UserData data;

  UpdateProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      success: json['success'],
      message: json['message'],
      data: UserData.fromJson(json['data']['user']),
    );
  }
}

