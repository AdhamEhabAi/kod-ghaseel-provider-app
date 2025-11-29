// 1) Data model
class ReportData {
  final String avgOrderText;             // e.g. '25 ريال'
  final double acceptanceRate;           // 0.96
  final int profit;                      // e.g. 245
  final int ordersCount;                 // e.g. 10
  final int ordersGoal;                  // e.g. 300
  final int doneToday;                   // e.g. 10
  final int targetToday;                 // e.g. 12
  final List<String> encouragements;     // e.g. ["واصل تميزك!", "إنت قدّها ,كفو! 💪"]
  final List<EarningRow> lastEarnings;   // list items
  final String profitTitle;              // e.g. "أرباح اليوم" or "أرباح الشهر"
  final double progressValue;            // e.g. 0.82 (progress percentage as decimal)
  final String ordersTitle;              // e.g. "طلبات اليوم" or "طلبات الشهر"

  ReportData({
    required this.avgOrderText,
    required this.acceptanceRate,
    required this.profit,
    required this.ordersCount,
    required this.ordersGoal,
    required this.doneToday,
    required this.targetToday,
    required this.encouragements,
    required this.lastEarnings,
    required this.profitTitle,
    required this.progressValue,
    required this.ordersTitle,
  });
}

class EarningRow {
  final String amount;   // '+25'
  final String name;     // 'أحمد محمد'
  final String subtitle; // 'غسيل خارجي - 3:30 م'
  EarningRow({required this.amount, required this.name, required this.subtitle});
}
