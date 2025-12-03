class MarkAsReadResponse {
  final bool success;
  final String message;

  MarkAsReadResponse({
    required this.success,
    required this.message,
  });

  factory MarkAsReadResponse.fromJson(Map<String, dynamic> json) {
    return MarkAsReadResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}
