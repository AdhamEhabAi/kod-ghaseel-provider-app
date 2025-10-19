import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/setting_app_bar.dart';
import '../widgets/bullet_widget.dart';
import '../widgets/choice_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  static const primary = Color(0xFF00D8FF);
  int? helpful;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingAppBar(title: s.faq_title),
            SizedBox(height: 35.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.faq_q_how_long_arrive,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    s.faq_a_quick_booking_time, // "Quick booking: 15–30 min"
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF9AA3AA),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Bullet(text: s.faq_bullet_scheduled),   // "Scheduled: per selected time"
                  SizedBox(height: 6.h),
                  Bullet(text: s.faq_bullet_peak),        // "Peak times: up to 45 min"
                  SizedBox(height: 20.h),
                  Text(
                    s.faq_did_this_help,                  // "Did this solve your issue?"
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primary,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ChoicePill(
                        label: s.yes,                     // "Yes"
                        selected: helpful == 1,
                        onTap: () => setState(() => helpful = 1),
                      ),
                      SizedBox(width: 12.w),
                      ChoicePill(
                        label: s.no,                      // "No"
                        selected: helpful == 0,
                        onTap: () => setState(() => helpful = 0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
