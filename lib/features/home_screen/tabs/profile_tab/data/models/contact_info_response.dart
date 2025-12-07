class ContactInfoResponse {
  final bool success;
  final ContactInfoData? data;

  ContactInfoResponse({
    required this.success,
    this.data,
  });

  factory ContactInfoResponse.fromJson(Map<String, dynamic> json) {
    return ContactInfoResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? ContactInfoData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class ContactInfoData {
  final int id;
  final String siteName;
  final String phone;
  final String whatsapp;
  final String email;
  final String website;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? snapchat;
  final String? youtube;
  final String? tiktok;
  final String? linkedin;
  final String address;
  final double latitude;
  final double longitude;
  final Map<String, String>? workingHours;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  ContactInfoData({
    required this.id,
    required this.siteName,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.website,
    this.facebook,
    this.twitter,
    this.instagram,
    this.snapchat,
    this.youtube,
    this.tiktok,
    this.linkedin,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.workingHours,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactInfoData.fromJson(Map<String, dynamic> json) {
    return ContactInfoData(
      id: int.tryParse(json['id'].toString()) ?? 0,
      siteName: json['site_name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      whatsapp: json['whatsapp']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      facebook: json['facebook']?.toString(),
      twitter: json['twitter']?.toString(),
      instagram: json['instagram']?.toString(),
      snapchat: json['snapchat']?.toString(),
      youtube: json['youtube']?.toString(),
      tiktok: json['tiktok']?.toString(),
      linkedin: json['linkedin']?.toString(),
      address: json['address']?.toString() ?? '',
      latitude: (json['latitude'] is num)
          ? (json['latitude'] as num).toDouble()
          : double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: (json['longitude'] is num)
          ? (json['longitude'] as num).toDouble()
          : double.tryParse(json['longitude'].toString()) ?? 0.0,
      workingHours: json['working_hours'] != null
          ? Map<String, String>.from(
        (json['working_hours'] as Map).map(
              (key, value) => MapEntry(key.toString(), value.toString()),
        ),
      )
          : null,
      isActive: int.tryParse(json['is_active'].toString()) ?? 0,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'site_name': siteName,
      'phone': phone,
      'whatsapp': whatsapp,
      'email': email,
      'website': website,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'snapchat': snapchat,
      'youtube': youtube,
      'tiktok': tiktok,
      'linkedin': linkedin,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'working_hours': workingHours,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}