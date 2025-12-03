class GetAllNotificationsResponse {
  final bool success;
  final List<NotificationItem> data;

  GetAllNotificationsResponse({
    required this.success,
    required this.data,
  });

  factory GetAllNotificationsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllNotificationsResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>)
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
    );
  }
}

class NotificationItem {
  final int id;
  final int? deliveryUserId;
  final String title;
  final String description;
  final String? link;
  final String type;
  final int? orderId;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  final int isRead;
  final String? readAt;

  NotificationItem({
    required this.id,
    this.deliveryUserId,
    required this.title,
    required this.description,
    this.link,
    required this.type,
    this.orderId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.isRead,
    this.readAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      deliveryUserId: json['delivery_user_id'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
      type: json['type'],
      orderId: json['order_id'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isRead: json['is_read'],
      readAt: json['read_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'delivery_user_id': deliveryUserId,
      'title': title,
      'description': description,
      'link': link,
      'type': type,
      'order_id': orderId,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_read': isRead,
      'read_at': readAt,
    };
  }
  int get daysBetween {
    final parsedDate = DateTime.tryParse(createdAt);
    if (parsedDate == null) return 0;

    final notificationDate = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    return today.difference(notificationDate).inDays;
  }
}
