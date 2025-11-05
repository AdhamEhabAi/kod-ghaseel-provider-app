/// success : true
/// message : "تم إرسال رمز تأكيد للرقم الجديد"
/// data : {"pin_code":"3879","expires_in_minutes":10}

class RequestUpdatePhoneNumberResponse {
  RequestUpdatePhoneNumberResponse({
      this.success, 
      this.message, 
      this.data,});

  RequestUpdatePhoneNumberResponse.fromJson(dynamic json) {
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

/// pin_code : "3879"
/// expires_in_minutes : 10

class Data {
  Data({
      this.pinCode, 
      this.expiresInMinutes,});

  Data.fromJson(dynamic json) {
    pinCode = json['pin_code'];
    expiresInMinutes = json['expires_in_minutes'];
  }
  String? pinCode;
  int? expiresInMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pin_code'] = pinCode;
    map['expires_in_minutes'] = expiresInMinutes;
    return map;
  }

}