class CheckSessionValidationResponse {
  bool? success;
  UserData? data;

  CheckSessionValidationResponse({this.success, this.data});

  CheckSessionValidationResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) map['data'] = data?.toJson();
    return map;
  }
}

class UserData {
  int? id;
  String? phone;
  String? fullName;
  String? email;
  String? profileImage;
  String? dateOfBirth;
  String? gender;
  String? city;
  String? address;
  String? status;
  String? phoneVerified;
  String? deviceToken;
  String? fcm;
  String? platform;
  String? appVersion;
  String? vehicleType;
  String? vehiclePlate;
  String? licenseNumber;
  String? onlineStatus;
  String? offlineUntil;
  String? lastSeen;
  String? createdAt;
  String? updatedAt;
  String? lastLogin;

  UserData({
    this.id,
    this.phone,
    this.fullName,
    this.email,
    this.profileImage,
    this.dateOfBirth,
    this.gender,
    this.city,
    this.address,
    this.status,
    this.phoneVerified,
    this.deviceToken,
    this.fcm,
    this.platform,
    this.appVersion,
    this.vehicleType,
    this.vehiclePlate,
    this.licenseNumber,
    this.onlineStatus,
    this.offlineUntil,
    this.lastSeen,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
  });

  UserData.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    fullName = json['full_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    city = json['city'];
    address = json['address'];
    status = json['status'];
    phoneVerified = json['phone_verified'];
    deviceToken = json['device_token'];
    fcm = json['fcm'];
    platform = json['platform'];
    appVersion = json['app_version'];
    vehicleType = json['vehicle_type'];
    vehiclePlate = json['vehicle_plate'];
    licenseNumber = json['license_number'];
    onlineStatus = json['online_status'];
    offlineUntil = json['offline_until'];
    lastSeen = json['last_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['phone'] = phone;
    map['full_name'] = fullName;
    map['email'] = email;
    map['profile_image'] = profileImage;
    map['date_of_birth'] = dateOfBirth;
    map['gender'] = gender;
    map['city'] = city;
    map['address'] = address;
    map['status'] = status;
    map['phone_verified'] = phoneVerified;
    map['device_token'] = deviceToken;
    map['fcm'] = fcm;
    map['platform'] = platform;
    map['app_version'] = appVersion;
    map['vehicle_type'] = vehicleType;
    map['vehicle_plate'] = vehiclePlate;
    map['license_number'] = licenseNumber;
    map['online_status'] = onlineStatus;
    map['offline_until'] = offlineUntil;
    map['last_seen'] = lastSeen;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['last_login'] = lastLogin;

    return map;
  }
}
