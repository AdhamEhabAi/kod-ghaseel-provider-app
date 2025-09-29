import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text('🧑🏻‍🦱',style: TextStyle(fontSize: 32.sp),)
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("مرحباً سارة 👋", style: AppTextStyle.blackW500Size16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 12.w),
                        Text(
                          "شارع الملك فهد، الرياض",
                          style: AppTextStyle.blackW500Size10,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 20),

            InkWell(
              onTap: () {
                // GoRouter.of(context).push(AppRouter.walletScreen);
              },
              child: SvgPicture.asset(Assets.walletIcon, color: Colors.black),
            ),

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
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
