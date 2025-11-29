class OrderStage {
  final int id;
  final String stage;
  final String stageTime;
  final String? notes;

  OrderStage({
    required this.id,
    required this.stage,
    required this.stageTime,
    this.notes,
  });

  factory OrderStage.fromJson(Map<String, dynamic> json) {
    return OrderStage(
      id: int.tryParse(json['id'].toString()) ?? 0,
      stage: json['stage']?.toString() ?? '',
      stageTime: json['stage_time']?.toString() ?? '',
      notes: json['notes']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stage': stage,
      'stage_time': stageTime,
      'notes': notes,
    };
  }
}

class OrderStagesData {
  final int orderId;
  final List<OrderStage> stages;
  final String? currentStage;
  final String? nextStage;
  final int totalStages;
  final int completedStages;

  OrderStagesData({
    required this.orderId,
    required this.stages,
    this.currentStage,
    this.nextStage,
    required this.totalStages,
    required this.completedStages,
  });

  factory OrderStagesData.fromJson(Map<String, dynamic> json) {
    return OrderStagesData(
      orderId: int.tryParse(json['order_id'].toString()) ?? 0,
      stages: (json['stages'] as List<dynamic>?)
              ?.map((e) => OrderStage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currentStage: json['current_stage']?.toString(),
      nextStage: json['next_stage']?.toString(),
      totalStages: int.tryParse(json['total_stages'].toString()) ?? 0,
      completedStages: int.tryParse(json['completed_stages'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'stages': stages.map((e) => e.toJson()).toList(),
      'current_stage': currentStage,
      'next_stage': nextStage,
      'total_stages': totalStages,
      'completed_stages': completedStages,
    };
  }
}

