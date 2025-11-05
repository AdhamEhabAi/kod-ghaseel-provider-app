/// success : true
/// message : "تم تغيير رقم الهاتف بنجاح"
/// data : {"old_phone":"01234567890","new_phone":"09876543210"}

class VerifyChangePhoneResponse {
  VerifyChangePhoneResponse({
      this.success, 
      this.message, 
      this.data,});

  VerifyChangePhoneResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// old_phone : "01234567890"
/// new_phone : "09876543210"

class Data {
  Data({
      this.oldPhone, 
      this.newPhone,});

  Data.fromJson(dynamic json) {
    oldPhone = json['old_phone'];
    newPhone = json['new_phone'];
  }
  String? oldPhone;
  String? newPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['old_phone'] = oldPhone;
    map['new_phone'] = newPhone;
    return map;
  }

}