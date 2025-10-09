import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class EncourageCard extends StatelessWidget {
  const EncourageCard({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      padding: EdgeInsetsGeometry.symmetric(vertical: 9.h),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadiusGeometry.circular(12.r),
      ),
      child: Center(child: Text(title,style: AppTextStyle.blackW600Size16Roboto,)),
    );
  }
}
