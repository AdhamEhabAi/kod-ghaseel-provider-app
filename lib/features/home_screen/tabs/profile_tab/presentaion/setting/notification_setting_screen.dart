import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/setting/widgets/notification_setting_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

bool paymentNotify = false;
bool messageNotify = false;
bool reminderNotify = false;
bool offersNotify = false;

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
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
              onChange: (value) {
                setState(() {
                  paymentNotify = value;
                });
              },
            ),
            SizedBox(height: 24.h),
            NotificationSettingWidget(
              title: s.notifications_messages,
              isOn: messageNotify,
              onChange: (value) {
                setState(() {
                  messageNotify = value;
                });
              },
            ),
            SizedBox(height: 24.h),
            NotificationSettingWidget(
              title: s.notifications_reminders,
              isOn: reminderNotify,
              onChange: (value) {
                setState(() {
                  reminderNotify = value;
                });
              },
            ),
            SizedBox(height: 24.h),
            NotificationSettingWidget(
              title: s.notifications_offers,
              isOn: offersNotify,
              onChange: (value) {
                setState(() {
                  offersNotify = value;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 104.w, vertical: 19.h),
                elevation: 0,
                backgroundColor: AppStyle.primaryColorOpacity10,
              ),
              onPressed: () {
                // TODO: save settings
              },
              child: Text(s.save, style: AppTextStyle.primaryW700Size16),
            ),
          ],
        ),
      ),
    );
  }
}
