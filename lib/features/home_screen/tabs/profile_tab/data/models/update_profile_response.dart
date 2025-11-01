/// success : true
/// message : "تم تحديث الملف الشخصي بنجاح"

class UpdateProfileResponse {

  bool? success;
  String? message;

  UpdateProfileResponse({
    this.success,
    this.message,});


  factory UpdateProfileResponse.fromJson(dynamic json) {
    return UpdateProfileResponse(
        success: json['success']?? false,
        message: json['message'] ?? ""
    );
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}