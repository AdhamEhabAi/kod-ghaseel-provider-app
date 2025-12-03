class DeleteNotificationResponse {
  final bool success;
  final String message;

  DeleteNotificationResponse({
    required this.success,
    required this.message,
  });

  factory DeleteNotificationResponse.fromJson(Map<String, dynamic> json) {
    return DeleteNotificationResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}
