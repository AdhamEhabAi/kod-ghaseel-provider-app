import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';

class UpperCardProgress extends StatelessWidget {
  const UpperCardProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Color(0xFFDAF1F6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تقدمك',
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              Text(
                '95%',
                style: AppTextStyle.blackW700Size26.copyWith(
                  fontSize: 45.sp,
                ),
              ),
              Text(
                'تويوتا كامري 2022',
                style: AppTextStyle.greyW400Size14.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 150.w,
            height: 150.w,
            child: DashedCircularProgressBar.aspectRatio(
              aspectRatio: 1,
              progress: 75,
              startAngle: 225,
              sweepAngle: 270,
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              foregroundStrokeWidth: 12,
              backgroundStrokeWidth: 12,
              animation: true,
              seekSize: 20,
              seekColor: AppStyle.primaryColor,
              child: Center(
                child: Container(
                  width: 105.w,
                  height: 105.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '16:45',
                          style: AppTextStyle.blackW500Size20.copyWith(fontSize: 24.sp),
                        ),
                        Text(
                          'دقيقة : ثانية',
                          style: AppTextStyle.greyW400Size14.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w500),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
