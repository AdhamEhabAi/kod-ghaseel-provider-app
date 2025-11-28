class StatisticsResponse {
  final bool success;
  final StatisticsData data;

  StatisticsResponse({
    required this.success,
    required this.data,
  });

  factory StatisticsResponse.fromJson(Map<String, dynamic> json) {
    return StatisticsResponse(
      success: json['success'] ?? false,
      data: StatisticsData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class StatisticsData {
  final CompletedOrders completedOrders;
  final Commission commission;
  final double avgOrdersPerDay;
  final double acceptanceRate;
  final double cancellationRate;
  final Rating rating;
  final double avgDailyRevenue;
  final Targets targets;
  final List<LastEarning> lastEarnings;
  final CommissionSettings commissionSettings;

  StatisticsData({
    required this.completedOrders,
    required this.commission,
    required this.avgOrdersPerDay,
    required this.acceptanceRate,
    required this.cancellationRate,
    required this.rating,
    required this.avgDailyRevenue,
    required this.targets,
    required this.lastEarnings,
    required this.commissionSettings,
  });

  factory StatisticsData.fromJson(Map<String, dynamic> json) {
    return StatisticsData(
      completedOrders: CompletedOrders.fromJson(
        json['completed_orders'] as Map<String, dynamic>,
      ),
      commission: Commission.fromJson(
        json['commission'] as Map<String, dynamic>,
      ),
      avgOrdersPerDay: (json['avg_orders_per_day'] as num?)?.toDouble() ?? 0.0,
      acceptanceRate: (json['acceptance_rate'] as num?)?.toDouble() ?? 0.0,
      cancellationRate: (json['cancellation_rate'] as num?)?.toDouble() ?? 0.0,
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
      avgDailyRevenue: (json['avg_daily_revenue'] as num?)?.toDouble() ?? 0.0,
      targets: Targets.fromJson(json['targets'] as Map<String, dynamic>),
      lastEarnings: (json['last_earnings'] as List<dynamic>?)
              ?.map((e) => LastEarning.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      commissionSettings: CommissionSettings.fromJson(
        json['commission_settings'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completed_orders': completedOrders.toJson(),
      'commission': commission.toJson(),
      'avg_orders_per_day': avgOrdersPerDay,
      'acceptance_rate': acceptanceRate,
      'cancellation_rate': cancellationRate,
      'rating': rating.toJson(),
      'avg_daily_revenue': avgDailyRevenue,
      'targets': targets.toJson(),
      'last_earnings': lastEarnings.map((e) => e.toJson()).toList(),
      'commission_settings': commissionSettings.toJson(),
    };
  }
}

class CompletedOrders {
  final int today;
  final int month;

  CompletedOrders({
    required this.today,
    required this.month,
  });

  factory CompletedOrders.fromJson(Map<String, dynamic> json) {
    return CompletedOrders(
      today: int.tryParse(json['today'].toString()) ?? 0,
      month: int.tryParse(json['month'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today': today,
      'month': month,
    };
  }
}

class Commission {
  final double today;
  final double month;

  Commission({
    required this.today,
    required this.month,
  });

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission(
      today: (json['today'] as num?)?.toDouble() ?? 0.0,
      month: (json['month'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today': today,
      'month': month,
    };
  }
}

class Rating {
  final double today;
  final double month;
  final int ratingsCountToday;
  final int ratingsCountMonth;

  Rating({
    required this.today,
    required this.month,
    required this.ratingsCountToday,
    required this.ratingsCountMonth,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      today: (json['today'] as num?)?.toDouble() ?? 0.0,
      month: (json['month'] as num?)?.toDouble() ?? 0.0,
      ratingsCountToday: int.tryParse(json['ratings_count_today'].toString()) ?? 0,
      ratingsCountMonth: int.tryParse(json['ratings_count_month'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today': today,
      'month': month,
      'ratings_count_today': ratingsCountToday,
      'ratings_count_month': ratingsCountMonth,
    };
  }
}

class Targets {
  final RevenueTarget revenue;
  final RevenueMonthlyTarget revenueMonthly;
  final WashingCountTarget washingCount;
  final WashingCountMonthlyTarget washingCountMonthly;

  Targets({
    required this.revenue,
    required this.revenueMonthly,
    required this.washingCount,
    required this.washingCountMonthly,
  });

  factory Targets.fromJson(Map<String, dynamic> json) {
    return Targets(
      revenue: RevenueTarget.fromJson(
        json['revenue'] as Map<String, dynamic>,
      ),
      revenueMonthly: RevenueMonthlyTarget.fromJson(
        json['revenue_monthly'] as Map<String, dynamic>,
      ),
      washingCount: WashingCountTarget.fromJson(
        json['washing_count'] as Map<String, dynamic>,
      ),
      washingCountMonthly: WashingCountMonthlyTarget.fromJson(
        json['washing_count_monthly'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'revenue': revenue.toJson(),
      'revenue_monthly': revenueMonthly.toJson(),
      'washing_count': washingCount.toJson(),
      'washing_count_monthly': washingCountMonthly.toJson(),
    };
  }
}

class RevenueTarget {
  final double target;
  final double achievedToday;
  final double achievedMonth;
  final double percentageToday;
  final double percentageMonth;

  RevenueTarget({
    required this.target,
    required this.achievedToday,
    required this.achievedMonth,
    required this.percentageToday,
    required this.percentageMonth,
  });

  factory RevenueTarget.fromJson(Map<String, dynamic> json) {
    return RevenueTarget(
      target: (json['target'] as num?)?.toDouble() ?? 0.0,
      achievedToday: (json['achieved_today'] as num?)?.toDouble() ?? 0.0,
      achievedMonth: (json['achieved_month'] as num?)?.toDouble() ?? 0.0,
      percentageToday: (json['percentage_today'] as num?)?.toDouble() ?? 0.0,
      percentageMonth: (json['percentage_month'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'achieved_today': achievedToday,
      'achieved_month': achievedMonth,
      'percentage_today': percentageToday,
      'percentage_month': percentageMonth,
    };
  }
}

class RevenueMonthlyTarget {
  final double target;
  final double achieved;
  final double percentage;

  RevenueMonthlyTarget({
    required this.target,
    required this.achieved,
    required this.percentage,
  });

  factory RevenueMonthlyTarget.fromJson(Map<String, dynamic> json) {
    return RevenueMonthlyTarget(
      target: (json['target'] as num?)?.toDouble() ?? 0.0,
      achieved: (json['achieved'] as num?)?.toDouble() ?? 0.0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'achieved': achieved,
      'percentage': percentage,
    };
  }
}

class WashingCountTarget {
  final int target;
  final int achievedToday;
  final int achievedMonth;
  final double percentageToday;
  final double percentageMonth;

  WashingCountTarget({
    required this.target,
    required this.achievedToday,
    required this.achievedMonth,
    required this.percentageToday,
    required this.percentageMonth,
  });

  factory WashingCountTarget.fromJson(Map<String, dynamic> json) {
    return WashingCountTarget(
      target: int.tryParse(json['target'].toString()) ?? 0,
      achievedToday: int.tryParse(json['achieved_today'].toString()) ?? 0,
      achievedMonth: int.tryParse(json['achieved_month'].toString()) ?? 0,
      percentageToday: (json['percentage_today'] as num?)?.toDouble() ?? 0.0,
      percentageMonth: (json['percentage_month'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'achieved_today': achievedToday,
      'achieved_month': achievedMonth,
      'percentage_today': percentageToday,
      'percentage_month': percentageMonth,
    };
  }
}

class WashingCountMonthlyTarget {
  final int target;
  final int achieved;
  final double percentage;

  WashingCountMonthlyTarget({
    required this.target,
    required this.achieved,
    required this.percentage,
  });

  factory WashingCountMonthlyTarget.fromJson(Map<String, dynamic> json) {
    return WashingCountMonthlyTarget(
      target: int.tryParse(json['target'].toString()) ?? 0,
      achieved: int.tryParse(json['achieved'].toString()) ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target': target,
      'achieved': achieved,
      'percentage': percentage,
    };
  }
}

class LastEarning {
  final int deliveryOrderId;
  final int orderId;
  final String date;
  final String time;
  final String orderType;
  final double orderAmount;
  final double commission;
  final String completedAt;
  final StatisticsServiceInfo serviceInfo;
  final StatisticsCustomerInfo customerInfo;
  final StatisticsCarInfo carInfo;

  LastEarning({
    required this.deliveryOrderId,
    required this.orderId,
    required this.date,
    required this.time,
    required this.orderType,
    required this.orderAmount,
    required this.commission,
    required this.completedAt,
    required this.serviceInfo,
    required this.customerInfo,
    required this.carInfo,
  });

  factory LastEarning.fromJson(Map<String, dynamic> json) {
    return LastEarning(
      deliveryOrderId: int.tryParse(json['delivery_order_id'].toString()) ?? 0,
      orderId: int.tryParse(json['order_id'].toString()) ?? 0,
      date: json['date']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      orderType: json['order_type']?.toString() ?? '',
      orderAmount: (json['order_amount'] as num?)?.toDouble() ?? 0.0,
      commission: (json['commission'] as num?)?.toDouble() ?? 0.0,
      completedAt: json['completed_at']?.toString() ?? '',
      serviceInfo: StatisticsServiceInfo.fromJson(
        json['service_info'] as Map<String, dynamic>,
      ),
      customerInfo: StatisticsCustomerInfo.fromJson(
        json['customer_info'] as Map<String, dynamic>,
      ),
      carInfo: StatisticsCarInfo.fromJson(
        json['car_info'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_order_id': deliveryOrderId,
      'order_id': orderId,
      'date': date,
      'time': time,
      'order_type': orderType,
      'order_amount': orderAmount,
      'commission': commission,
      'completed_at': completedAt,
      'service_info': serviceInfo.toJson(),
      'customer_info': customerInfo.toJson(),
      'car_info': carInfo.toJson(),
    };
  }
}

class StatisticsServiceInfo {
  final int? serviceId;
  final String serviceName;
  final int? packageServiceId;
  final int? packageId;
  final int? companyPackageId;

  StatisticsServiceInfo({
    this.serviceId,
    required this.serviceName,
    this.packageServiceId,
    this.packageId,
    this.companyPackageId,
  });

  factory StatisticsServiceInfo.fromJson(Map<String, dynamic> json) {
    return StatisticsServiceInfo(
      serviceId: json['service_id'] != null
          ? int.tryParse(json['service_id'].toString())
          : null,
      serviceName: json['service_name']?.toString() ?? '',
      packageServiceId: json['package_service_id'] != null
          ? int.tryParse(json['package_service_id'].toString())
          : null,
      packageId: json['package_id'] != null
          ? int.tryParse(json['package_id'].toString())
          : null,
      companyPackageId: json['company_package_id'] != null
          ? int.tryParse(json['company_package_id'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'service_name': serviceName,
      'package_service_id': packageServiceId,
      'package_id': packageId,
      'company_package_id': companyPackageId,
    };
  }
}

class StatisticsCustomerInfo {
  final String name;
  final String phone;

  StatisticsCustomerInfo({
    required this.name,
    required this.phone,
  });

  factory StatisticsCustomerInfo.fromJson(Map<String, dynamic> json) {
    return StatisticsCustomerInfo(
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }
}

class StatisticsCarInfo {
  final String nickname;
  final String manufacturer;
  final String model;

  StatisticsCarInfo({
    required this.nickname,
    required this.manufacturer,
    required this.model,
  });

  factory StatisticsCarInfo.fromJson(Map<String, dynamic> json) {
    return StatisticsCarInfo(
      nickname: json['nickname']?.toString() ?? '',
      manufacturer: json['manufacturer']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'manufacturer': manufacturer,
      'model': model,
    };
  }
}

class CommissionSettings {
  final double? percentage;
  final double? fixed;
  final String type;

  CommissionSettings({
    this.percentage,
    this.fixed,
    required this.type,
  });

  factory CommissionSettings.fromJson(Map<String, dynamic> json) {
    return CommissionSettings(
      percentage: json['percentage'] != null
          ? (json['percentage'] as num).toDouble()
          : null,
      fixed: json['fixed'] != null ? (json['fixed'] as num).toDouble() : null,
      type: json['type']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'percentage': percentage,
      'fixed': fixed,
      'type': type,
    };
  }
}

