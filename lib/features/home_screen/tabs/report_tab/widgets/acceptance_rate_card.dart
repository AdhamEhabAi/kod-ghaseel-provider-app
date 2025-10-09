import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class AcceptanceRate extends StatelessWidget {
  const AcceptanceRate({super.key,required this.rate});

  final double rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("معدل القبول", style: AppTextStyle.blackW500Size13),
          SizedBox(height: 15.h),
          CircularPercentIndicator(
            startAngle: 180,
            radius: 35,
            center: Text(
              "${rate*100}%",
              style: AppTextStyle.blackW600Size14Roboto.copyWith(
                fontFamily: "Lato",
              ),
            ),
            lineWidth: 10,
            percent: 0.50,
            progressColor: AppStyle.primaryColor,
            backgroundColor: Colors.white,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
