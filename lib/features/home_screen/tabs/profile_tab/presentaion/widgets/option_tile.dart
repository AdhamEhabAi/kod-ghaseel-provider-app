import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../Utilites/app_fonts/font.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final String iconPath; // SVG icon asset path
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  iconPath,
                  width: 24.w,
                  height: 24.h,
                ),
                SizedBox(width: 14.w),
                Text(
                  title,
                  textDirection: TextDirection.ltr,
                  style: AppTextStyle.blackW600Size16Roboto,
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 18.w, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
