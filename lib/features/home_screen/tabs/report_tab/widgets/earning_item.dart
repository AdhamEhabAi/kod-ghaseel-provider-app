import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';

class EarningItem extends StatelessWidget {
  final String amount, name, subtitle;

  const EarningItem({super.key,
    required this.amount,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.1))
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.check_rounded, color:Color(0xff3BA935),fontWeight: FontWeight.w600,),
          SizedBox(width: 6.w,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.blackW400Size14
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: AppTextStyle.blackW400Size10,
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style:AppTextStyle.primaryW700Size25,
              ),
              SizedBox(width: 5.w,),
              Text(
                "ريال",
                style:AppTextStyle.primaryW500Size12,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
