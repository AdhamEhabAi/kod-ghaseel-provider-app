import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../../Utilites/app_style/style.dart';


class SettingItemsRow extends StatelessWidget {
  const SettingItemsRow({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap
  });
  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
              decoration: BoxDecoration(
                color:AppStyle.primaryColorOpacity10,
                borderRadius: BorderRadiusGeometry.circular(16.r),
              ),
              child: Icon(icon,color: AppStyle.primaryColor,),
            ),
            SizedBox(width: 30.w,),
            Text(title,style: AppTextStyle.blackW500Size14,),
            Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,size: 18.w,)
          ],
        ),
      ),
    );
  }
}
