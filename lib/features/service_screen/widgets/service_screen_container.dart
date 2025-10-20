import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utilites/app_fonts/font.dart';

class ServiceScreenContainer extends StatelessWidget {
  const ServiceScreenContainer({
    super.key, required this.title, required this.subtitle,
  });
  final String title;
  final String subtitle;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical:16.h ,horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(16.r),
          border: Border.all(color: Color(0xffEAECF0), )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: AppTextStyle.blackW600Size14Roboto,),
          Text(subtitle,style:  AppTextStyle.greyTextW600Size12),
        ],
      ),
    );
  }
}
