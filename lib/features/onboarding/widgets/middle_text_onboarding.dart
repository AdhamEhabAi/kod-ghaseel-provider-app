import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utilites/app_fonts/font.dart';

class MiddleTextOnBoarding extends StatelessWidget {
  const MiddleTextOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          Text(
            'مرحباً بك',
            style: AppTextStyle.whiteW600Size16Roboto.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 28.sp,
            ),
          ),
          Text(
            'خدمة غسيل سيارات متنقلة نقدم الخدمة في مكان العميل بواسطة فريق مؤهل  ومجهز.\n تهدف الخدمة إلى توفير راحة وسهولة لأصحاب\n السيارات من خلال تقديم  خدمات غسيل عالية الجودة ومريحة للعملاء في مكانهم.',
            style: AppTextStyle.whiteW500Size16.copyWith(letterSpacing: -0.41,height: 1.5),
          ),
        ],
      ),
    );
  }
}
