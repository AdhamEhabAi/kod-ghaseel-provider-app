class OrdersResponse {
  final bool success;
  final List<Order> data;
  final int total;
  final int limit;
  final int offset;

  OrdersResponse({
    required this.success,
    required this.data,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      total: int.tryParse(json['total'].toString()) ?? 0,
      limit: int.tryParse(json['limit'].toString()) ?? 0,
      offset: int.tryParse(json['offset'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }
}

class Order {
  final int id;
  final int deliveryUserId;
  final int orderId;
  final String? assignedAt;
  final String? pickedAt;
  final String? startedAt;
  final String? completedAt;
  final String status;
  final String orderDate;
  final String orderTime;
  final String orderType;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final String deliveryName;
  final String deliveryPhone;
  final String deliveryOnlineStatus;
  final String? deliveryOfflineUntil;
  final String? deliveryLastSeen;
  final int userId;
  final int? serviceId;
  final int? packageServiceId;
  final int? packageId;
  final int? companyPackageId;
  final int locationId;
  final int? carId;
  final List<int> optionalServiceIds;
  final List<int> optionalServiceCounts;
  final String orderStatus;
  final String? washingFrequency;
  final String orderCreatedAt;
  final String? serviceName;
  final String? servicePrice;
  final String? serviceDescription;
  final String? packageServiceName;
  final String? packageServicePrice;
  final String? packageServiceDescription;
  final String? packageName;
  final String? packageDescription;
  final String? companyPackageName;
  final String? companyPackageDescription;
  final String? companyPackageType;
  final int? companyPackageWashingCount;
  final String locationName;
  final String latitude;
  final String longitude;
  final String locationAddress;
  final String? carNickname;
  final String? carColor;
  final String? plateNumber;
  final String? carManufacturerName;
  final String? carModelName;
  final int customerId;
  final String customerName;
  final String customerPhone;
  final String? customerEmail;
  final int invoiceId;
  final String totalBeforeDiscount;
  final String discountAmount;
  final String totalAfterDiscount;
  final String invoicePaymentMethod;
  final String invoiceStatus;
  final DeliveryInfo? deliveryInfo;
  final CustomerInfo? customerInfo;
  final LocationInfo? locationInfo;
  final CarInfo? carInfo;
  final ServiceInfo? serviceInfo;
  final PackageServiceInfo? packageServiceInfo;
  final CompanyPackageInfo? companyPackageInfo;
  final InvoiceInfo? invoiceInfo;
  final TrackingInfo? trackingInfo;

  Order({
    required this.id,
    required this.deliveryUserId,
    required this.orderId,
    this.assignedAt,
    this.pickedAt,
    this.startedAt,
    this.completedAt,
    required this.status,
    required this.orderDate,
    required this.orderTime,
    required this.orderType,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryName,
    required this.deliveryPhone,
    required this.deliveryOnlineStatus,
    this.deliveryOfflineUntil,
    this.deliveryLastSeen,
    required this.userId,
    this.serviceId,
    this.packageServiceId,
    this.packageId,
    this.companyPackageId,
    required this.locationId,
    this.carId,
    required this.optionalServiceIds,
    required this.optionalServiceCounts,
    required this.orderStatus,
    this.washingFrequency,
    required this.orderCreatedAt,
    this.serviceName,
    this.servicePrice,
    this.serviceDescription,
    this.packageServiceName,
    this.packageServicePrice,
    this.packageServiceDescription,
    this.packageName,
    this.packageDescription,
    this.companyPackageName,
    this.companyPackageDescription,
    this.companyPackageType,
    this.companyPackageWashingCount,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.locationAddress,
    this.carNickname,
    this.carColor,
    this.plateNumber,
    this.carManufacturerName,
    this.carModelName,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    this.customerEmail,
    required this.invoiceId,
    required this.totalBeforeDiscount,
    required this.discountAmount,
    required this.totalAfterDiscount,
    required this.invoicePaymentMethod,
    required this.invoiceStatus,
    this.deliveryInfo,
    this.customerInfo,
    this.locationInfo,
    this.carInfo,
    this.serviceInfo,
    this.packageServiceInfo,
    this.companyPackageInfo,
    this.invoiceInfo,
    this.trackingInfo,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.tryParse(json['id'].toString()) ?? 0,
      deliveryUserId: int.tryParse(json['delivery_user_id'].toString()) ?? 0,
      orderId: int.tryParse(json['order_id'].toString()) ?? 0,
      assignedAt: json['assigned_at']?.toString(),
      pickedAt: json['picked_at']?.toString(),
      startedAt: json['started_at']?.toString(),
      completedAt: json['completed_at']?.toString(),
      status: json['status']?.toString() ?? '',
      orderDate: json['order_date']?.toString() ?? '',
      orderTime: json['order_time']?.toString() ?? '',
      orderType: json['order_type']?.toString() ?? '',
      notes: json['notes']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      deliveryName: json['delivery_name']?.toString() ?? '',
      deliveryPhone: json['delivery_phone']?.toString() ?? '',
      deliveryOnlineStatus: json['delivery_online_status']?.toString() ?? '',
      deliveryOfflineUntil: json['delivery_offline_until']?.toString(),
      deliveryLastSeen: json['delivery_last_seen']?.toString(),
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      serviceId: json['service_id'] != null
          ? int.tryParse(json['service_id'].toString())
          : null,
      packageServiceId: json['package_service_id'] != null
          ? int.tryParse(json['package_service_id'].toString())
          : null,
      packageId: json['package_id'] != null
          ? int.tryParse(json['package_id'].toString())
          : null,
      companyPackageId: json['company_package_id'] != null
          ? int.tryParse(json['company_package_id'].toString())
          : null,
      locationId: int.tryParse(json['location_id'].toString()) ?? 0,
      carId:
          json['car_id'] != null ? int.tryParse(json['car_id'].toString()) : null,
      optionalServiceIds: (json['optional_service_ids'] as List<dynamic>?)
              ?.map((e) => int.tryParse(e.toString()) ?? 0)
              .toList() ??
          [],
      optionalServiceCounts: (json['optional_service_counts'] as List<dynamic>?)
              ?.map((e) => int.tryParse(e.toString()) ?? 0)
              .toList() ??
          [],
      orderStatus: json['order_status']?.toString() ?? '',
      washingFrequency: json['washing_frequency']?.toString(),
      orderCreatedAt: json['order_created_at']?.toString() ?? '',
      serviceName: json['service_name']?.toString(),
      servicePrice: json['service_price']?.toString(),
      serviceDescription: json['service_description']?.toString(),
      packageServiceName: json['package_service_name']?.toString(),
      packageServicePrice: json['package_service_price']?.toString(),
      packageServiceDescription: json['package_service_description']?.toString(),
      packageName: json['package_name']?.toString(),
      packageDescription: json['package_description']?.toString(),
      companyPackageName: json['company_package_name']?.toString(),
      companyPackageDescription: json['company_package_description']?.toString(),
      companyPackageType: json['company_package_type']?.toString(),
      companyPackageWashingCount: json['company_package_washing_count'] != null
          ? int.tryParse(json['company_package_washing_count'].toString())
          : null,
      locationName: json['location_name']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      locationAddress: json['location_address']?.toString() ?? '',
      carNickname: json['car_nickname']?.toString(),
      carColor: json['car_color']?.toString(),
      plateNumber: json['plate_number']?.toString(),
      carManufacturerName: json['car_manufacturer_name']?.toString(),
      carModelName: json['car_model_name']?.toString(),
      customerId: int.tryParse(json['customer_id'].toString()) ?? 0,
      customerName: json['customer_name']?.toString() ?? '',
      customerPhone: json['customer_phone']?.toString() ?? '',
      customerEmail: json['customer_email']?.toString(),
      invoiceId: int.tryParse(json['invoice_id'].toString()) ?? 0,
      totalBeforeDiscount: json['total_before_discount']?.toString() ?? '0.00',
      discountAmount: json['discount_amount']?.toString() ?? '0.00',
      totalAfterDiscount: json['total_after_discount']?.toString() ?? '0.00',
      invoicePaymentMethod: json['invoice_payment_method']?.toString() ?? '',
      invoiceStatus: json['invoice_status']?.toString() ?? '',
      deliveryInfo: json['delivery_info'] != null
          ? DeliveryInfo.fromJson(json['delivery_info'] as Map<String, dynamic>)
          : null,
      customerInfo: json['customer_info'] != null
          ? CustomerInfo.fromJson(json['customer_info'] as Map<String, dynamic>)
          : null,
      locationInfo: json['location_info'] != null
          ? LocationInfo.fromJson(json['location_info'] as Map<String, dynamic>)
          : null,
      carInfo: json['car_info'] != null
          ? CarInfo.fromJson(json['car_info'] as Map<String, dynamic>)
          : null,
      serviceInfo: json['service_info'] != null
          ? ServiceInfo.fromJson(json['service_info'] as Map<String, dynamic>)
          : null,
      packageServiceInfo: json['package_service_info'] != null
          ? PackageServiceInfo.fromJson(
              json['package_service_info'] as Map<String, dynamic>)
          : null,
      companyPackageInfo: json['company_package_info'] != null
          ? CompanyPackageInfo.fromJson(
              json['company_package_info'] as Map<String, dynamic>)
          : null,
      invoiceInfo: json['invoice_info'] != null
          ? InvoiceInfo.fromJson(json['invoice_info'] as Map<String, dynamic>)
          : null,
      trackingInfo: json['tracking_info'] != null
          ? TrackingInfo.fromJson(json['tracking_info'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'delivery_user_id': deliveryUserId,
      'order_id': orderId,
      'assigned_at': assignedAt,
      'picked_at': pickedAt,
      'started_at': startedAt,
      'completed_at': completedAt,
      'status': status,
      'order_date': orderDate,
      'order_time': orderTime,
      'order_type': orderType,
      'notes': notes,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'delivery_name': deliveryName,
      'delivery_phone': deliveryPhone,
      'delivery_online_status': deliveryOnlineStatus,
      'delivery_offline_until': deliveryOfflineUntil,
      'delivery_last_seen': deliveryLastSeen,
      'user_id': userId,
      'service_id': serviceId,
      'package_service_id': packageServiceId,
      'package_id': packageId,
      'company_package_id': companyPackageId,
      'location_id': locationId,
      'car_id': carId,
      'optional_service_ids': optionalServiceIds,
      'optional_service_counts': optionalServiceCounts,
      'order_status': orderStatus,
      'washing_frequency': washingFrequency,
      'order_created_at': orderCreatedAt,
      'service_name': serviceName,
      'service_price': servicePrice,
      'service_description': serviceDescription,
      'package_service_name': packageServiceName,
      'package_service_price': packageServicePrice,
      'package_service_description': packageServiceDescription,
      'package_name': packageName,
      'package_description': packageDescription,
      'company_package_name': companyPackageName,
      'company_package_description': companyPackageDescription,
      'company_package_type': companyPackageType,
      'company_package_washing_count': companyPackageWashingCount,
      'location_name': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'location_address': locationAddress,
      'car_nickname': carNickname,
      'car_color': carColor,
      'plate_number': plateNumber,
      'car_manufacturer_name': carManufacturerName,
      'car_model_name': carModelName,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_email': customerEmail,
      'invoice_id': invoiceId,
      'total_before_discount': totalBeforeDiscount,
      'discount_amount': discountAmount,
      'total_after_discount': totalAfterDiscount,
      'invoice_payment_method': invoicePaymentMethod,
      'invoice_status': invoiceStatus,
      'delivery_info': deliveryInfo?.toJson(),
      'customer_info': customerInfo?.toJson(),
      'location_info': locationInfo?.toJson(),
      'car_info': carInfo?.toJson(),
      'service_info': serviceInfo?.toJson(),
      'package_service_info': packageServiceInfo?.toJson(),
      'company_package_info': companyPackageInfo?.toJson(),
      'invoice_info': invoiceInfo?.toJson(),
      'tracking_info': trackingInfo?.toJson(),
    };
  }
}

class DeliveryInfo {
  final int id;
  final String name;
  final String phone;
  final String onlineStatus;
  final String? offlineUntil;
  final String? lastSeen;

  DeliveryInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.onlineStatus,
    this.offlineUntil,
    this.lastSeen,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      onlineStatus: json['online_status']?.toString() ?? '',
      offlineUntil: json['offline_until']?.toString(),
      lastSeen: json['last_seen']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'online_status': onlineStatus,
      'offline_until': offlineUntil,
      'last_seen': lastSeen,
    };
  }
}

class CustomerInfo {
  final int id;
  final String name;
  final String phone;
  final String? email;

  CustomerInfo({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) {
    return CustomerInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}

class LocationInfo {
  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final String address;

  LocationInfo({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

class CarInfo {
  final int id;
  final String nickname;
  final String color;
  final String plateNumber;
  final String manufacturer;
  final String model;

  CarInfo({
    required this.id,
    required this.nickname,
    required this.color,
    required this.plateNumber,
    required this.manufacturer,
    required this.model,
  });

  factory CarInfo.fromJson(Map<String, dynamic> json) {
    return CarInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      nickname: json['nickname']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      plateNumber: json['plate_number']?.toString() ?? '',
      manufacturer: json['manufacturer']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'color': color,
      'plate_number': plateNumber,
      'manufacturer': manufacturer,
      'model': model,
    };
  }
}

class ServiceInfo {
  final int id;
  final String name;
  final String price;
  final String description;

  ServiceInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}

class PackageServiceInfo {
  final int id;
  final String name;
  final String price;
  final String description;

  PackageServiceInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory PackageServiceInfo.fromJson(Map<String, dynamic> json) {
    return PackageServiceInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}

class CompanyPackageInfo {
  final int id;
  final String name;
  final String description;
  final String type;
  final int? washingCount;

  CompanyPackageInfo({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.washingCount,
  });

  factory CompanyPackageInfo.fromJson(Map<String, dynamic> json) {
    return CompanyPackageInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      washingCount: json['washing_count'] != null
          ? int.tryParse(json['washing_count'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'washing_count': washingCount,
    };
  }
}

class InvoiceInfo {
  final int id;
  final String totalBeforeDiscount;
  final String discountAmount;
  final String totalAfterDiscount;
  final String paymentMethod;
  final String status;

  InvoiceInfo({
    required this.id,
    required this.totalBeforeDiscount,
    required this.discountAmount,
    required this.totalAfterDiscount,
    required this.paymentMethod,
    required this.status,
  });

  factory InvoiceInfo.fromJson(Map<String, dynamic> json) {
    return InvoiceInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      totalBeforeDiscount: json['total_before_discount']?.toString() ?? '0.00',
      discountAmount: json['discount_amount']?.toString() ?? '0.00',
      totalAfterDiscount: json['total_after_discount']?.toString() ?? '0.00',
      paymentMethod: json['payment_method']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_before_discount': totalBeforeDiscount,
      'discount_amount': discountAmount,
      'total_after_discount': totalAfterDiscount,
      'payment_method': paymentMethod,
      'status': status,
    };
  }
}

class TrackingInfo {
  final String? assignedAt;
  final String? pickedAt;
  final String? startedAt;
  final String? completedAt;
  final String status;
  final String? notes;

  TrackingInfo({
    this.assignedAt,
    this.pickedAt,
    this.startedAt,
    this.completedAt,
    required this.status,
    this.notes,
  });

  factory TrackingInfo.fromJson(Map<String, dynamic> json) {
    return TrackingInfo(
      assignedAt: json['assigned_at']?.toString(),
      pickedAt: json['picked_at']?.toString(),
      startedAt: json['started_at']?.toString(),
      completedAt: json['completed_at']?.toString(),
      status: json['status']?.toString() ?? '',
      notes: json['notes']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assigned_at': assignedAt,
      'picked_at': pickedAt,
      'started_at': startedAt,
      'completed_at': completedAt,
      'status': status,
      'notes': notes,
    };
  }
}

