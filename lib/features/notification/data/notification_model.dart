import 'package:flutter/material.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

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

  /// ✅ Localized label (Arabic / English)
  static String localizedRelativeLabel(BuildContext context, int diff) {
    final s = S.of(context);

    if (diff == 0) return s.today;
    if (diff == 1) return s.yesterday;
    if (diff == 2) return s.twoDaysAgo;
    return s.daysAgo(diff);
  }
}

