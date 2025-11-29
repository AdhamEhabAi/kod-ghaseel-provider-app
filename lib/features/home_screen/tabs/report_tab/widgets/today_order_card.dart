import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- added for localization

class TodayOrdersCard extends StatelessWidget {
  const TodayOrdersCard({
    super.key,
    required this.done,
    required this.target,
    required this.title,
  });

  final int done, target;
  final String title; // Dynamic title for daily/monthly

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization instance
    var size = MediaQuery.of(context).size;

    // Calculate progress value from done/target, clamped between 0.0 and 1.0
    final progressValue = target > 0
        ? (done / target).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 10.h),
      width: size.width * (200 / 390),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(title, style: AppTextStyle.blackW500Size13),
                  SizedBox(height: 10.h),
                  Text(
                    "$done/$target",
                    style: AppTextStyle.blackW600Size16Roboto.copyWith(
                      fontFamily: "Lato",
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset("assets/icons/shield_icon_primary.svg"),
            ],
          ),
          SizedBox(width: 10.w),
          Directionality(
            textDirection: TextDirection.ltr,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                minHeight: 12.h,
                borderRadius: BorderRadius.circular(25.r),
                value: progressValue,
                backgroundColor: AppStyle.primaryColorOpacity10,
                color: AppStyle.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
