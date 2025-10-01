import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../core/router/router.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "مرحباً محمود 👋",
                  style: AppTextStyle.whiteW800Size24Roboto,
                ),
                SizedBox(height: 5.h),
                Text("مزود خدمه", style: AppTextStyle.whiteW600Size14Roboto),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 11.w),
              decoration: BoxDecoration(
                color: AppStyle.primaryColorOpacity52,
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Row(
                children: [
                  Text("متاح الأن", style: AppTextStyle.whiteW600Size14Roboto),
                  SizedBox(width: 8.w),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppStyle.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            CircleAvatar(
              backgroundColor: AppStyle.primaryColorOpacity52,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.notificationScreen);
                },
                child: SvgPicture.asset(
                  Assets.notificationIcon,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}
