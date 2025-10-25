class RequestPinResponse {
  final bool success;
  final String message;
  final PinData? data;

  RequestPinResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RequestPinResponse.fromJson(Map<String, dynamic> json) {
    return RequestPinResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? PinData.fromJson(json['data']) : null,
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

class PinData {
  final String pinCode;
  final int expiresInMinutes;

  PinData({
    required this.pinCode,
    required this.expiresInMinutes,
  });

  factory PinData.fromJson(Map<String, dynamic> json) {
    return PinData(
      pinCode: json['pin_code'] ?? '',
      expiresInMinutes: json['expires_in_minutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pin_code': pinCode,
      'expires_in_minutes': expiresInMinutes,
    };
  }
}
