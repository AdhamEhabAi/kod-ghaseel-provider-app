class LoginResponse {
  final bool success;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
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

class LoginData {
  final User user;
  final String sessionToken;

  LoginData({
    required this.user,
    required this.sessionToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: User.fromJson(json['user']),
      sessionToken: json['session_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'session_token': sessionToken,
    };
  }
}

class User {
  final int id;
  final String phone;
  final String fullName;
  final String status;
  final bool phoneVerified;

  User({
    required this.id,
    required this.phone,
    required this.fullName,
    required this.status,
    required this.phoneVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final dynamic verifiedValue = json['phone_verified'];
    bool parsedPhoneVerified;

    if (verifiedValue is bool) {
      parsedPhoneVerified = verifiedValue;
    } else if (verifiedValue is String) {
      parsedPhoneVerified = verifiedValue == '1' || verifiedValue.toLowerCase() == 'true';
    } else if (verifiedValue is int) {
      parsedPhoneVerified = verifiedValue == 1;
    } else {
      parsedPhoneVerified = false;
    }

    return User(
      id: int.tryParse(json['id'].toString()) ?? 0,
      phone: json['phone']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      phoneVerified: parsedPhoneVerified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'full_name': fullName,
      'status': status,
      'phone_verified': phoneVerified,
    };
  }
}
