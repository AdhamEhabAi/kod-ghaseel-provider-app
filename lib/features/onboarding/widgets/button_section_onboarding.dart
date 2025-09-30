import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../Utilites/app_fonts/font.dart';
import '../../../Utilites/app_style/style.dart';
import '../../../core/router/router.dart';
import '../../../shared/shared_widget.dart';

class ButtonSectionOnBoarding extends StatelessWidget {
  const ButtonSectionOnBoarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        spacing: 8.w,
        children: [
          DefaultButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.registerScreen);
            },
            backgroundColorButton: AppStyle.white,
            borderRadius: BorderRadius.circular(50.r),
            titleWidget: Text(
              'تسجيــــــل الدخول',
              style: AppTextStyle.whiteW600Size16Roboto.copyWith(color: AppStyle.primaryColor),
            ),
          ),
          DefaultButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.registerScreen);
            },
            backgroundColorButton: Colors.transparent,
            borderRadius: BorderRadius.circular(50.r),
            borderSideColor: AppStyle.white,
            titleWidget: Text(
              'إنشــــــــاء حساب',
              style: AppTextStyle.whiteW600Size16Roboto,
            ),
          ),

        ],
      ),
    );
  }
}
