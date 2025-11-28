import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

class ButtonSectionOnBoarding extends StatelessWidget {
  const ButtonSectionOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // ✅ Localization instance

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 62.w),
      child: Column(
        spacing: 8.w,
        children: [
          DefaultButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.loginScreen);
            },
            backgroundColorButton: AppStyle.primaryColor,
            borderRadius: BorderRadius.circular(50.r),
            titleWidget: Text(
              s.login, // ✅ Localized
              style: AppTextStyle.whiteW600Size16Roboto,
            ),
          ),
        ],
      ),
    );
  }
}
