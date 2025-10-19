import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';

class EarningItem extends StatelessWidget {
  final String amount;
  final String name;
  final String subtitle;
  final String currencyLabel; // e.g. "ريال"

  const EarningItem({
    super.key,
    required this.amount,
    required this.name,
    required this.subtitle,
    this.currencyLabel = 'ريال',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_rounded,
            color: const Color(0xff3BA935),
            size: 22.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyle.blackW400Size14),
                SizedBox(height: 2.h),
                Text(subtitle, style: AppTextStyle.blackW400Size10),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: AppTextStyle.primaryW700Size25,
              ),
              SizedBox(width: 4.w),
              Text(
                currencyLabel,
                style: AppTextStyle.primaryW500Size12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
