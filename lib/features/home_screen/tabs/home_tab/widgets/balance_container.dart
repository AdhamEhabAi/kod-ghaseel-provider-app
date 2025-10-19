import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

class BalanceContainer extends StatelessWidget {
  const BalanceContainer({
    super.key,
    required this.completedOrders,
    required this.amount,
    this.currencyIcon = Assets.riyal,
  });

  final int completedOrders;
  final num amount;
  final String currencyIcon;

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 20.w,
      ),
      decoration: BoxDecoration(
        color: AppStyle.primaryColor.withOpacity(.50),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.today_earnings,
                style: AppTextStyle.whiteW500Size14.copyWith(
                  color: Colors.white.withOpacity(.80),
                ),
              ),
              Text(
                l.completed_orders(completedOrders),
                style: AppTextStyle.whiteW700Size20,
              ),
            ],
          ),

          const Spacer(),

          // Amount + currency icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                // If you want locale-aware number formatting, plug intl NumberFormat here
                amount.toString(),
                style: AppTextStyle.whiteW500Size40.copyWith(
                  fontFamily: "Lexend",
                ),
              ),
              SizedBox(width: 6.w),
              SvgPicture.asset(
                currencyIcon,
                width: 20.w,
                height: 25.h,
                color: AppStyle.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
