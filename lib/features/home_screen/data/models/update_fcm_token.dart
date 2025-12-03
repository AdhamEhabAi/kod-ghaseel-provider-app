class UpdateFcmTokenResponse {
  final bool success;
  final String message;
  final FcmData? data;

  UpdateFcmTokenResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UpdateFcmTokenResponse.fromJson(Map<String, dynamic> json) {
    return UpdateFcmTokenResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] != null ? FcmData.fromJson(json["data"]) : null,
    );
  }
}

class FcmData {
  final String fcm;

  FcmData({
    required this.fcm,
  });

  factory FcmData.fromJson(Map<String, dynamic> json) {
    return FcmData(
      fcm: json["fcm"] ?? "",
    );
  }
}
