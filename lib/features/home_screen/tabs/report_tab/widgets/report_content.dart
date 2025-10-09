import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/widgets/profit_card.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/widgets/small_stat_card.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/widgets/today_order_card.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../data/model.dart';
import 'acceptance_rate_card.dart';
import 'earning_item.dart';
import 'encourage_card.dart';

class ReportContent extends StatelessWidget {
  final ReportData data;
  const ReportContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SmallStatCard(title: 'متوسط الطلب', value: data.avgOrderText),
                  SizedBox(height: 10.h),
                  AcceptanceRate(
                    rate: data.acceptanceRate,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 3,
              child: ProfitCard(
                profit: data.profit,
                ordersCount: data.ordersCount,
                ordersGoal: data.ordersGoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TodayOrdersCard(
                done: data.doneToday,
                target: data.targetToday,
              ),
            ),
            SizedBox(width: 17.w),
            Expanded(
              flex: 2,
              child: Column(
                spacing: 12.h,
                children: data.encouragements
                    .map((t) => EncourageCard(title: t))
                    .toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: 22.h),
        Text('آخر الأرباح', style: AppTextStyle.blackW600Size15Roboto),
        SizedBox(height: 10.h),
        ...data.lastEarnings.map((e) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: EarningItem(amount: e.amount, name: e.name, subtitle: e.subtitle),
        )),
        SizedBox(height: 80.h),
      ],
    );
  }
}
