import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // adjust path if needed

class NumberOfOrdersContainer extends StatelessWidget {
  const NumberOfOrdersContainer({
    super.key,
    required this.totalOrders,
    required this.dailyOrders,
  });

  final int totalOrders;
  final int dailyOrders;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * (156 / 390),
      height: 156.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(19.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Expanded(
                child: Text(
                  l.orders_so_far_title, // "عدد الطلبات حتى الآن"
                  style: AppTextStyle.blackW500Size14,
                  softWrap: true,
                ),
              ),
              SvgPicture.asset(Assets.boltIcon),
            ],
          ),
          SizedBox(height: 10.h),

          // Total orders: "125 طلب/طلبات"
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: totalOrders.toString(),
                  style: AppTextStyle.blackW600Size24Roboto,
                ),
                TextSpan(
                  text: ' ${l.orders_count(totalOrders)}',
                  style: AppTextStyle.blackW400Size11Opacity40,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Daily orders row: icon + "10 طلب/طلبات يومياً"
          Row(
            children: [
              SvgPicture.asset(Assets.uploadIcon),
              SizedBox(width: 7.w),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: dailyOrders.toString(),
                      style: AppTextStyle.blackW600Size16Roboto,
                    ),
                    TextSpan(
                      text: ' ${l.daily_orders(dailyOrders)}',
                      style: AppTextStyle.blackW400Size11Opacity40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
