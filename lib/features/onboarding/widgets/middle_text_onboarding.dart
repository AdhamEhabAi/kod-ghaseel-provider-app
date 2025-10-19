import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

class MiddleTextOnBoarding extends StatelessWidget {
  const MiddleTextOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ localization instance

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        spacing: 20.h,
        children: [
          Text(
            s.appName,
            style: AppTextStyle.primaryW700Size34,
          ),
          Text(
            s.onboardingDescription, // ✅ localized description
            style: AppTextStyle.primaryW500Size16.copyWith(
              letterSpacing: -0.41.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
