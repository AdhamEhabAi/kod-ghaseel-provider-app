import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import '../../../../../core/router/router.dart';

class UserDataSection extends StatelessWidget {
  const UserDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12.w,vertical: 12.h),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppStyle.white,
            radius: 24.r,
            child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 20.sp)),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("محمد احمد", style: AppTextStyle.blackW600Size15Roboto),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.trophyIconSVG,
                    color: Color(0xffFE6800),
                  ),
                  SizedBox(width: 5.w),
                  Text("عميل", style: AppTextStyle.blackW400Size11),
                ],
              ),
              Text(
                "غسيل خارجي - تويوتا كامري",
                style: AppTextStyle.blackW400Size11.copyWith(
                  color: Color(0x66131313),
                ),
              ),
              Text("فى انتظارك",style: AppTextStyle.primaryW600Size12,)
            ],
          ),
          Spacer(),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(Assets.messageIcon),
                  SizedBox(width: 12.w,),
                  SvgPicture.asset(Assets.phoneIcon),
                ],
              ),
              SizedBox(height: 22.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppStyle.greenColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "بدء التنفيذ",
                  style: AppTextStyle.whiteW600Size12Roboto,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
