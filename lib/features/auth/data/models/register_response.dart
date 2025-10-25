class RegisterResponse {
  final bool success;
  final String message;
  final RegisterData? data;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class RegisterData {
  final int userId;
  final String pinCode;
  final bool phoneVerificationRequired;
  final int expiresInMinutes;

  RegisterData({
    required this.userId,
    required this.pinCode,
    required this.phoneVerificationRequired,
    required this.expiresInMinutes,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      pinCode: json['pin_code'].toString(),
      phoneVerificationRequired: json['phone_verification_required'] ?? false,
      expiresInMinutes: int.tryParse(json['expires_in_minutes'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'pin_code': pinCode,
      'phone_verification_required': phoneVerificationRequired,
      'expires_in_minutes': expiresInMinutes,
    };
  }
}
