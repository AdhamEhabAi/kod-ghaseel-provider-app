import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

class UpperCardProgress extends StatelessWidget {
  final Duration elapsedTime;
  final double progress;
  final bool isTimerRunning;

  const UpperCardProgress({
    super.key,
    required this.elapsedTime,
    required this.progress,
    required this.isTimerRunning,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
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
                s.yourProgress,
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              Text(
                '${progress.toStringAsFixed(0)}%',
                style: AppTextStyle.blackW700Size26.copyWith(
                  fontSize: 45.sp,
                ),
              ),
              Text(
                s.serviceProgress,
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
              progress: progress.clamp(0.0, 100.0),
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
                          _formatDuration(elapsedTime),
                          style: AppTextStyle.blackW500Size20.copyWith(fontSize: 24.sp),
                        ),
                        Text(
                          s.minutesSeconds,
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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
