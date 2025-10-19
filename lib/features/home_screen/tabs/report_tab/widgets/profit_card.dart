import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class ProfitCard extends StatelessWidget {
  const ProfitCard({
    super.key,
    required this.ordersCount,
    required this.ordersGoal,
    required this.profit,
    required this.progressValue,
  });

  final int profit, ordersCount, ordersGoal;
  final double progressValue; // e.g. 0.82

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final percent = (progressValue * 100).round();

    return Container(
      width: MediaQuery.of(context).size.width * (222 / 390),
      height: MediaQuery.of(context).size.height * (218 / 844),
      decoration: BoxDecoration(
        color: const Color(0xFF192126),
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.only(top: 31.h, bottom: 20.h, left: 11.w, right: 11.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            s.today_profit, // localized
            style: AppTextStyle.whiteW400Size14,
          ),

          SizedBox(height: 6.h),

          // Profit value
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$profit',
                style: AppTextStyle.whiteW600Size39Roboto.copyWith(
                  fontSize: 45.sp,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                s.currency_sar, // localized (e.g., "ريال" / "SAR")
                style: AppTextStyle.whiteW400Size16Roboto.copyWith(fontSize: 23.sp),
              ),
              SizedBox(height: 11.h),
            ],
          ),

          // Orders count
          Text(
            s.from_orders(ordersCount), // localized, e.g. "من 5 طلبات" / "From 5 orders"
            style: AppTextStyle.whiteW400Size14.copyWith(color: Colors.white70),
          ),

          // Goal row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${ordersGoal} ${s.currency_sar}', // e.g. "250 ريال" / "250 SAR"
                style: AppTextStyle.whiteW600Size12Roboto,
              ),
            ],
          ),

          SizedBox(height: 5.h),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8.r),
                minHeight: 4.h,
                value: progressValue,
                backgroundColor: const Color(0x6B005265),
                color: AppStyle.white,
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Progress text
          Text(
            '$percent% ${s.completed}', // e.g. "82% مكتمل" / "82% completed"
            style: AppTextStyle.whiteW500Size10,
          ),
        ],
      ),
    );
  }
}
