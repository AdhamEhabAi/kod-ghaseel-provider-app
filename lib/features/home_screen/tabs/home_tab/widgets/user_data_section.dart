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
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppStyle.primaryColorOpacity52,
          radius: 24.r,
          child: Text('🧑🏻‍🦱',style: TextStyle(fontSize: 20.sp),),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "سارة محمد",
                style: AppTextStyle.blackW600Size16Roboto,
              ),
              Text(
                "شارع الملك فهد, الرياض",
                style: AppTextStyle.greyTextW600Size12.copyWith(fontSize: 16.sp),
              ),
            ],
          ),
        ),
        IconButton(
          icon: SvgPicture.asset(Assets.messageIcon),
          onPressed: () {
            GoRouter.of(context).push(AppRouter.chatScreen);
          },
        ),
        IconButton(
          icon:  SvgPicture.asset(Assets.phoneIcon),
          onPressed: () {},
        ),
      ],
    );
  }
}
