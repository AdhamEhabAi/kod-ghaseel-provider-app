import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Utilites/app_fonts/font.dart';
import '../../Utilites/app_style/style.dart';

class SettingAppBar extends StatelessWidget {
  const SettingAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Spacer(),
              Text(title, style: AppTextStyle.blackW600Size16Roboto),
              Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  GoRouter.of(context).pop();
                },
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppStyle.whereto),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: Icon(Icons.arrow_forward_ios_rounded, size: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
