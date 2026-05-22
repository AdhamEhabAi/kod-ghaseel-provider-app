import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/setting/widgets/notification_setting_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/helpers/shared_prefrence.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  static const _kPayment = 'notif_payment';
  static const _kMessage = 'notif_message';
  static const _kReminder = 'notif_reminder';
  static const _kOffers = 'notif_offers';

  bool paymentNotify = true;
  bool messageNotify = true;
  bool reminderNotify = true;
  bool offersNotify = true;

  @override
  void initState() {
    super.initState();
    paymentNotify = AppSharedPreferences.getBool(_kPayment) ?? true;
    messageNotify = AppSharedPreferences.getBool(_kMessage) ?? true;
    reminderNotify = AppSharedPreferences.getBool(_kReminder) ?? true;
    offersNotify = AppSharedPreferences.getBool(_kOffers) ?? true;
  }

  Future<void> _save() async {
    await AppSharedPreferences.setBool(_kPayment, paymentNotify);
    await AppSharedPreferences.setBool(_kMessage, messageNotify);
    await AppSharedPreferences.setBool(_kReminder, reminderNotify);
    await AppSharedPreferences.setBool(_kOffers, offersNotify);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).save),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            SettingAppBar(title: s.notifications_title),
            SizedBox(height: 70.h),
            NotificationSettingWidget(
              title: s.notifications_payment,
              isOn: paymentNotify,
              onChange: (value) => setState(() => paymentNotify = value),
            ),
            SizedBox(height: 24.h),
            NotificationSettingWidget(
              title: s.notifications_messages,
              isOn: messageNotify,
              onChange: (value) => setState(() => messageNotify = value),
            ),
            SizedBox(height: 24.h),
            NotificationSettingWidget(
              title: s.notifications_reminders,
              isOn: reminderNotify,
              onChange: (value) => setState(() => reminderNotify = value),
            ),
            SizedBox(height: 24.h),
            NotificationSettingWidget(
              title: s.notifications_offers,
              isOn: offersNotify,
              onChange: (value) => setState(() => offersNotify = value),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 104.w, vertical: 19.h),
                elevation: 0,
                backgroundColor: AppStyle.primaryColorOpacity10,
              ),
              onPressed: _save,
              child: Text(s.save, style: AppTextStyle.primaryW700Size16),
            ),
          ],
        ),
      ),
    );
  }
}
