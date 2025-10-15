import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/setting_app_bar.dart';
import '../widgets/bullet_widget.dart';
import '../widgets/choice_widget.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  static const primary = Color(0xFF00D8FF);
  int? helpful; // null: لسه ما اختارش, 1: نعم, 0: لا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingAppBar(title: "الاسئلة الشائعة"),
            SizedBox(height: 35.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'كم من الوقت تحتاجون للوصول؟',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'الحجز السريع: 15 - 30 دقيقة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF9AA3AA),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Bullet(text: 'الحجز المجدول: حسب الموعد المختار'),
                  SizedBox(height: 6.h),
                  Bullet(text: 'أوقات الذروة: قد تستغرق 45 دقيقة كحد أقصى'),
                  SizedBox(height: 20.h),
                  Text(
                    'هل ساعدك ذلك في حل مشكلتك؟',
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
                        label: 'نعم',
                        selected: helpful == 1,
                        onTap: () => setState(() => helpful = 1),
                      ),
                      SizedBox(width: 12.w),
                      ChoicePill(
                        label: 'لا',
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


