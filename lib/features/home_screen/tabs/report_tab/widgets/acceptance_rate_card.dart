import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- l10n

class AcceptanceRate extends StatelessWidget {
  const AcceptanceRate({super.key, required this.rate});

  /// 0.0 .. 1.0
  final double rate;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final clamped = rate.clamp(0.0, 1.0);
    final percentText = '${(clamped * 100).toStringAsFixed(0)}%';

    return Container(
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(s.acceptance_rate, style: AppTextStyle.blackW500Size13),
          SizedBox(height: 12.h),
          CircularPercentIndicator(
            startAngle: 180,
            radius: 35.r,
            lineWidth: 10.w,
            percent: clamped,
            center: Text(
              percentText,
              style: AppTextStyle.blackW600Size14Roboto.copyWith(
                fontFamily: 'Lato',
              ),
            ),
            progressColor: AppStyle.primaryColor,
            backgroundColor: Colors.white,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}
