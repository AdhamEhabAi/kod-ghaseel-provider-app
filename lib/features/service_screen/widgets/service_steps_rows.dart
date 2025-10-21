import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

class ServiceStepsRows extends StatelessWidget {
  const ServiceStepsRows({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Localized text only; logic/structure unchanged
    final steps = <Map<String, String>>[
      {
        'title': s.step_arrival,                            // "الوصول للموقع" / "Arrival to location"
        'subtitle': s.timeRange('10:30', '11:00'),          // "10:30 - 11:00"
        'status': 'done'
      },
      {
        'title': s.step_checkCar,                           // "التحقق من السيارة" / "Check the car"
        'subtitle': s.nMinutes(5),                          // "5 دقائق" / "5 min"
        'status': 'done'
      },
      {
        'title': s.step_startWashing,                       // "بدء الغسيل" / "Start washing"
        'subtitle': s.nMinutesToFinish(3),                  // "3 دقائق حتى الانتهاء" / "3 min to finish"
        'status': 'active',
        'percent': '0.91', // 91%
      },
      {
        'title': s.step_drying,                             // "التجفيف" / "Drying"
        'subtitle': s.nMinutes(5),
        'status': 'pending'
      },
      {
        'title': s.step_finishService,                      // "إنهاء الخدمة" / "Finish service"
        'subtitle': '',
        'status': 'pending'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: steps.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final step = steps[index];
        final status = step['status']!;
        final isFirst = index == 0;
        final isLast = index == steps.length - 1;

        if (status == 'active') {
          final percent =
              double.tryParse(step['percent'] ?? '0')?.clamp(0.0, 1.0) ?? 0.0;

          return Container(
            padding: EdgeInsetsDirectional.only(
              end: 12.w,
              top: 12.h,
              bottom: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Center(
                  child: CircularPercentIndicator(
                    radius: 22.w,
                    lineWidth: 3.5.w,
                    percent: percent,
                    animation: true,
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: const Color(0xFFE8F6F4),
                    progressColor: AppStyle.primaryColor,
                    center: Text(
                      '${(percent * 100).round()}%',
                      style: AppTextStyle.blackW600Size14Roboto,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title'] ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.blackW600Size16Roboto
                            .copyWith(fontSize: 17.sp),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        step['subtitle'] ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.greyW600Size12Roboto.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildRowIcon(
              status,
              showTop: !isFirst,
              showBottom: !isLast,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] ?? '',
                    style: AppTextStyle.greyW600Size12Roboto.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  if ((step['subtitle'] ?? '').isNotEmpty)
                    Text(
                      step['subtitle']!,
                      style: AppTextStyle.greyW600Size12Roboto.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: status == 'done'
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRowIcon(
      String status, {
        bool showTop = true,
        bool showBottom = true,
      }) {
    switch (status) {
      case 'done':
        return Column(
          children: [
            if (showTop)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check, color: Colors.white, size: 30.w),
            ),
            if (showBottom)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
          ],
        );
      case 'pending':
      default:
        return Column(
          children: [
            if (showTop)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFBDBDBD), width: 2.w),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 30.sp,
                color: Colors.black,
              ),
            ),
            if (showBottom)
              Container(width: 2.w, height: 20.h, color: AppStyle.grey),
          ],
        );
    }
  }
}
