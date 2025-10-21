import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/setting_app_bar.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/service_steps_rows.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/widgets/upper_card_progress.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

class ServiceProgressScreen extends StatefulWidget {
  const ServiceProgressScreen({super.key});

  @override
  State<ServiceProgressScreen> createState() => _ServiceProgressScreenState();
}

class _ServiceProgressScreenState extends State<ServiceProgressScreen> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 8.h),
                SettingAppBar(title: s.orderProgressTitle), // "تقدم الطلب"
                SizedBox(height: 24.h),
                const UpperCardProgress(),
                SizedBox(height: 24.h),
                const ServiceStepsRows(),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        borderRadius: BorderRadius.circular(60.r),
                        backgroundColorButton: const Color(0xFFE9F9EE),
                        titleWidget: Text(
                          s.finishService, // "إنهاء الخدمة"
                          style: const TextStyle(
                            color: Color(0xFF17BF63),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: DefaultButton(
                        borderRadius: BorderRadius.circular(60.r),
                        backgroundColorButton: const Color(0xFFFBE6E6),
                        titleWidget: Text(
                          s.pauseTemporarily, // "إيقاف مؤقت"
                          style: const TextStyle(
                            color: Color(0xFFE53935),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
