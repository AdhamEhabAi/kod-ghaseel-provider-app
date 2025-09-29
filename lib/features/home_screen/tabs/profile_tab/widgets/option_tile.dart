import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Utilites/app_fonts/font.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const OptionTile({super.key, required this.title, required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black54, size: 30.w),
                SizedBox(width: 20.w,),
                Text(
                  title,
                  style: AppTextStyle.blackW600Size16Roboto,
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18.w),

          ],
        ),
      ),
    );
  }
}
