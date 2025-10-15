import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../shared/shared_widget.dart';

void showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        title: Center(
          child: Text('تسجيل الخروج!', style: AppTextStyle.blackW600Size24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
              backgroundColorButton: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              onPressed: () {
                GoRouter.of(context).go(AppRouter.loginScreen);
              },
              titleWidget: Text(
                'نعم, بالتأكيد!',
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  color: AppStyle.red,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            DefaultButton(
              backgroundColorButton: AppStyle.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
              onPressed: () {
                GoRouter.of(context).pop();
              },
              titleWidget: Text(
                'لا',
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  color: AppStyle.white,
                ),
              ),
            ),          ],
        ),
      );
    },
  );
}
