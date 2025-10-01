import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        color: AppStyle.primaryColor.withValues(alpha: .50),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "أرباح اليوم",
                style: AppTextStyle.whiteW500Size14.copyWith(color: Colors.white.withValues(alpha: .80)),
              ),
              Text(
                "12 طلب مكتمل",
                style: AppTextStyle.whiteW700Size20,
              ),
            ],
          ),
          Spacer(),
          Text(
            "245",
            style: AppTextStyle.whiteW500Size40.copyWith(
              fontFamily: "Lexend",
            ),
          ),
          SizedBox(width: 5.w),
          SvgPicture.asset(
            Assets.riyal,
            width: 20.w,
            height: 25.h,
            color: AppStyle.white,
          ),
        ],
      ),
    );
  }
}
