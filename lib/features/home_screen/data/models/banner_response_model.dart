class BannerResponse {
  final bool success;
  final List<BannerItem> data;

  BannerResponse({
    required this.success,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BannerItem.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class BannerItem {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final String linkUrl;
  final String displayType;
  final String targetApp;
  final int displayOrder;
  final int clickCount;
  final String createdAt;

  BannerItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.linkUrl,
    required this.displayType,
    required this.targetApp,
    required this.displayOrder,
    required this.clickCount,
    required this.createdAt,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: int.tryParse(json['id'].toString()) ?? 0,
      imageUrl: json['image_url']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      linkUrl: json['link_url']?.toString() ?? '',
      displayType: json['display_type']?.toString() ?? '',
      targetApp: json['target_app']?.toString() ?? '',
      displayOrder: int.tryParse(json['display_order'].toString()) ?? 0,
      clickCount: int.tryParse(json['click_count'].toString()) ?? 0,
      createdAt: json['created_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'title': title,
      'description': description,
      'link_url': linkUrl,
      'display_type': displayType,
      'target_app': targetApp,
      'display_order': displayOrder,
      'click_count': clickCount,
      'created_at': createdAt,
    };
  }
}
