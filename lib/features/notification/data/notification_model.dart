class NotificationModel {
  String title;
  String subtitle;
  DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.createdAt,
  });

  int get daysBetween {
    final da = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final db = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return db.difference(da).inDays;
  }

  static String arabicRelativeLabel(int diff) {
    if (diff == 0) return 'اليوم';
    if (diff == 1) return 'أمس';
    if (diff == 2) return 'منذ يومين';
    return 'منذ $diff أيام';
  }
}
