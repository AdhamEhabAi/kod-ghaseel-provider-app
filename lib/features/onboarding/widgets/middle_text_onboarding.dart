import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utilites/app_fonts/font.dart';

class MiddleTextOnBoarding extends StatelessWidget {
  const MiddleTextOnBoarding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        spacing: 20.h,
        children: [
          Text('كود غسيل', style: AppTextStyle.primaryW700Size34),
          Text(
            'خدمة غسيل سيارات متنقلة نقدم الخدمة في مكان العميل بواسطة فريق مؤهل  ومجهز',
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
