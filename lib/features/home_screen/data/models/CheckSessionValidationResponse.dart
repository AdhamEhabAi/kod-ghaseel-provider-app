/// success : true
/// data : {"id":1,"phone":"966501234567","full_name":"أحمد محمد","profile_image":null,"status":"active","phone_verified":true,"created_at":"2024-01-01 10:00:00","last_login":"2024-01-01 12:00:00"}

class CheckSessionValidationResponse {
  CheckSessionValidationResponse({this.success, this.data});

  bool? success;
  UserData? data;

  CheckSessionValidationResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : 1
/// phone : "966501234567"
/// full_name : "أحمد محمد"
/// profile_image : null
/// status : "active"
/// phone_verified : true
/// created_at : "2024-01-01 10:00:00"
/// last_login : "2024-01-01 12:00:00"

class UserData {
  UserData({
    this.id,
    this.phone,
    this.fullName,
    this.profileImage,
    this.status,
    this.phoneVerified,
    this.createdAt,
    this.lastLogin,
  });

  UserData.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    fullName = json['full_name'];
    profileImage = json['profile_image'];
    status = json['status'];
    phoneVerified = json['phone_verified'];
    createdAt = json['created_at'];
    lastLogin = json['last_login'];
  }

  int? id;
  String? phone;
  String? fullName;
  dynamic profileImage;
  String? status;
  bool? phoneVerified;
  String? createdAt;
  String? lastLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phone'] = phone;
    map['full_name'] = fullName;
    map['profile_image'] = profileImage;
    map['status'] = status;
    map['phone_verified'] = phoneVerified;
    map['created_at'] = createdAt;
    map['last_login'] = lastLogin;
    return map;
  }
}
