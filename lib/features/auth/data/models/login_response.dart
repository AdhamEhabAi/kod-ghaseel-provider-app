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
  final String profileImage;
  final String dateOfBirth;
  final String gender;
  final String city;
  final String address;
  final String status;
  final bool phoneVerified;
  final String deviceToken;
  final String platform;
  final String appVersion;
  final String vehicleType;
  final String vehiclePlate;
  final String licenseNumber;
  final String createdAt;
  final String updatedAt;
  final String lastLogin;

  User({
    required this.id,
    required this.phone,
    required this.fullName,
    required this.profileImage,
    required this.dateOfBirth,
    required this.gender,
    required this.city,
    required this.address,
    required this.status,
    required this.phoneVerified,
    required this.deviceToken,
    required this.platform,
    required this.appVersion,
    required this.vehicleType,
    required this.vehiclePlate,
    required this.licenseNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final dynamic verifiedValue = json['phone_verified'];
    bool parsedPhoneVerified;

    if (verifiedValue is bool) {
      parsedPhoneVerified = verifiedValue;
    } else if (verifiedValue is String) {
      parsedPhoneVerified =
          verifiedValue == '1' || verifiedValue.toLowerCase() == 'true';
    } else if (verifiedValue is int) {
      parsedPhoneVerified = verifiedValue == 1;
    } else {
      parsedPhoneVerified = false;
    }

    return User(
      id: int.tryParse(json['id'].toString()) ?? 0,
      phone: json['phone']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      profileImage: json['profile_image']?.toString() ?? '',
      dateOfBirth: json['date_of_birth']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      phoneVerified: parsedPhoneVerified,
      deviceToken: json['device_token']?.toString() ?? '',
      platform: json['platform']?.toString() ?? '',
      appVersion: json['app_version']?.toString() ?? '',
      vehicleType: json['vehicle_type']?.toString() ?? '',
      vehiclePlate: json['vehicle_plate']?.toString() ?? '',
      licenseNumber: json['license_number']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      lastLogin: json['last_login']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'full_name': fullName,
      'profile_image': profileImage,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'city': city,
      'address': address,
      'status': status,
      'phone_verified': phoneVerified,
      'device_token': deviceToken,
      'platform': platform,
      'app_version': appVersion,
      'vehicle_type': vehicleType,
      'vehicle_plate': vehiclePlate,
      'license_number': licenseNumber,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'last_login': lastLogin,
    };
  }
}
