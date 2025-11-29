import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // adjust if your l10n path differs

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
    required this.serviceDescription,
    required this.clientName,
    this.onViewPressed,
    this.isCompleted = false,
  });

  final String clientName;
  final String serviceDescription;
  final VoidCallback? onViewPressed; // optional callback for the "View" pill
  final bool isCompleted; // Whether the order is completed

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    return GestureDetector(
      onTap: onViewPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: isCompleted 
                ? Colors.green.withOpacity(0.5) 
                : const Color(0xffEAECF0), 
            width: 0.98,
          ),
          color: isCompleted 
              ? Colors.green.withOpacity(0.1) 
              : const Color(0xffF9FAFB),
        ),
        child: Column(
          children: [
            // Header row: client name + lightning icon + completed badge
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      clientName,
                      style: AppTextStyle.blackW500Size14.copyWith(
                        color: isCompleted ? Colors.green.shade700 : null,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isCompleted) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        l.completed,
                        style: AppTextStyle.blackW500Size10.copyWith(
                          color: Colors.white,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(width: 6.w),
                  SvgPicture.asset(
                    Assets.lightningIconSVG, 
                    height: 22.h,
                    colorFilter: isCompleted 
                        ? ColorFilter.mode(Colors.green, BlendMode.srcIn)
                        : null,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Rounded divider bar
            Container(
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                color: const Color(0xffE7E7E7),
                borderRadius: BorderRadius.circular(29.3.r),
              ),
            ),

            SizedBox(height: 11.7.h),

            // Bottom row: service description pill + "View" pill
            Row(
              children: [
                // Description pill
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(98.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.calenderScreenIconSVG, height: 18.h),
                      SizedBox(width: 6.w),
                      Flexible(
                        child: Text(
                          serviceDescription,
                          style: AppTextStyle.blackW500Size10,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

               Spacer(),

                // "View" pill
                InkWell(
                  borderRadius: BorderRadius.circular(98.r),
                  onTap: onViewPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(98.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l.view, // localized "عرض"
                          style: AppTextStyle.blackW700Size14Roboto.copyWith(fontFamily: "Inter"),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.h,
                          color: AppStyle.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
