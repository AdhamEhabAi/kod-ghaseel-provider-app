import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import '../../../../../core/router/router.dart';


class UserDataSection extends StatelessWidget {
  const UserDataSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppStyle.primaryColor,
            radius: 24.r,
            child: Text('🧑🏻‍🦱',style: TextStyle(fontSize: 20.sp),),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "محمد احمد",
                  style: AppTextStyle.blackW600Size16Roboto,
                ),
                Text(
                  "مزود الخدمة",
                  style: AppTextStyle.greyTextW600Size12.copyWith(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.green),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.chatScreen);
            },
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}