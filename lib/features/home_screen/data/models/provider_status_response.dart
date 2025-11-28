/// success : true
/// data : {"online_status":"online","offline_until":null}
/// or
/// data : {"online_status":"offline","offline_until":"2024-01-01 14:00:00"}

class ProviderStatusResponse {
  ProviderStatusResponse({this.success, this.data, this.message});

  bool? success;
  ProviderStatusData? data;
  String? message;

  ProviderStatusResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProviderStatusData.fromJson(json['data']) : null;
  }

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

/// online_status : "online" or "offline"
/// offline_until : "2024-01-01 14:00:00" or null

class ProviderStatusData {
  ProviderStatusData({
    this.onlineStatus,
    this.offlineUntil,
  });

  String? onlineStatus;
  String? offlineUntil;

  ProviderStatusData.fromJson(dynamic json) {
    onlineStatus = json['online_status'];
    offlineUntil = json['offline_until'];
  }

  bool get isOnline => onlineStatus?.toLowerCase() == 'online';
  bool get isOffline => onlineStatus?.toLowerCase() == 'offline';

  DateTime? get offlineUntilDateTime {
    if (offlineUntil == null) return null;
    try {
      return DateTime.parse(offlineUntil!);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['online_status'] = onlineStatus;
    map['offline_until'] = offlineUntil;
    return map;
  }
}

