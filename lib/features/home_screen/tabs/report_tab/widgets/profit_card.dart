import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class ProfitCard extends StatelessWidget {
  const ProfitCard({super.key,required this.ordersCount,required this.ordersGoal,required this.profit});

  final int profit, ordersCount, ordersGoal;


  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width*(222/390),
      height: MediaQuery.of(context).size.height*(218/844),
      decoration: BoxDecoration(
        color: const Color(0xFF192126),
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.only(top:31.h,bottom: 25.h,left: 11.w,right: 11.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'أرباح اليوم',
              style: AppTextStyle.whiteW400Size14
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                  '$profit',
                  style: AppTextStyle.whiteW600Size39Roboto.copyWith(fontSize: 45.sp,fontFamily: "Inter")
              ),
              SizedBox(width: 5.w,),
              Text(
                  'ريال',
                  style: AppTextStyle.whiteW400Size16Roboto.copyWith(fontSize: 23.sp)
              ),
              SizedBox(height: 11.h,),
            ],
          ),
          Text(
              'من $ordersCount طلبات',
              style: AppTextStyle.whiteW400Size14.copyWith(color: Colors.white70)
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("$ordersGoal ريال",style: AppTextStyle.whiteW600Size12Roboto,),
              ]
          ),
          SizedBox(height: 5.h,),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8.r),
                minHeight: 4.h,
                value:0.82,
                backgroundColor: Color(0x6b005265),
                color: AppStyle.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            ' ${(0.82 * 100).round()}% مكتمل',
            style: AppTextStyle.whiteW500Size10,
          ),
        ],
      ),
    );
  }
}
