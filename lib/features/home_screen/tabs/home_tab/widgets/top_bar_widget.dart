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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 15.w,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text('🧑🏻‍🦱',style: TextStyle(fontSize: 20.sp),)
            ),
            SizedBox(width: 5.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("مرحباً محمود 👋", style: AppTextStyle.whiteW500Size16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/trophy_icon.svg"),
                        Text(
                          "مندوب",
                          style: AppTextStyle.whiteW500Size10,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 11.w),
              decoration: BoxDecoration(
                color: AppStyle.primaryColorOpacity52,
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Row(
                children: [
                  Text("غير متاح",style: AppTextStyle.whiteW600Size12Roboto,),
                  SizedBox(width: 8.w,),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppStyle.red,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 20.w,),
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -5, end: 11),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.red,
                padding: EdgeInsets.all(5),
              ),
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
            SizedBox(width: 15.w,),
          ],
        ),
      ),
    );
  }
}
