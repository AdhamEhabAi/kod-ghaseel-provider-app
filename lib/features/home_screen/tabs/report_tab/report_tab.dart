import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/widgets/report_content.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/widgets/home_sliver_app_bar.dart';
import 'package:kod_ghaseel_provider_app/features/statics/controller/statics_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/statics/data/models/statistics_response.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'data/model.dart';

class ReportTab extends StatelessWidget {
  const ReportTab({super.key});

  // Helper function to format time from "HH:mm:ss" to "h:mm a" format
  static String _formatTime(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = parts[1];
        final period = hour >= 12 ? 'م' : 'ص';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '$displayHour:$minute $period';
      }
      return timeStr;
    } catch (e) {
      return timeStr;
    }
  }

  // Map LastEarning to EarningRow
  static EarningRow _mapLastEarningToEarningRow(
    LastEarning earning,
    S s,
  ) {
    final formattedTime = _formatTime(earning.time);
    return EarningRow(
      amount: '+${earning.commission.toStringAsFixed(0)}',
      name: earning.customerInfo.name,
      subtitle: s.service_example(earning.serviceInfo.serviceName, formattedTime),
    );
  }

  // Map StatisticsData to ReportData for daily tab
  static ReportData _mapToDailyReportData(StatisticsData data, S s) {
    final lastEarnings = data.lastEarnings
        .take(3)
        .map((e) => _mapLastEarningToEarningRow(e, s))
        .toList();

    // Calculate progress value from revenue percentage (convert from percentage to decimal)
    final progressValue = (data.targets.revenue.percentageToday / 100.0).clamp(0.0, 1.0);

    return ReportData(
      avgOrderText: data.avgDailyRevenue.toStringAsFixed(0),
      acceptanceRate: data.acceptanceRate / 100.0,
      profit: data.commission.today.toInt(),
      ordersCount: data.completedOrders.today,
      ordersGoal: data.targets.washingCount.target,
      doneToday: data.completedOrders.today,
      targetToday: data.targets.washingCount.target,
      encouragements: [s.keep_it_up, s.you_got_this],
      lastEarnings: lastEarnings,
      profitTitle: s.today_profit,
      progressValue: progressValue,
      ordersTitle: s.today_orders,
    );
  }

  // Map StatisticsData to ReportData for monthly tab
  static ReportData _mapToMonthlyReportData(StatisticsData data, S s) {
    final lastEarnings = data.lastEarnings
        .take(3)
        .map((e) => _mapLastEarningToEarningRow(e, s))
        .toList();

    final progressValue = (data.targets.revenueMonthly.percentage / 100.0).clamp(0.0, 1.0);

    return ReportData(
      avgOrderText: data.avgDailyRevenue.toStringAsFixed(0),
      acceptanceRate: data.acceptanceRate / 100.0, // Convert percentage to decimal
      profit: data.commission.month.toInt(),
      ordersCount: data.completedOrders.month,
      ordersGoal: data.targets.washingCountMonthly.target,
      doneToday: data.completedOrders.month,
      targetToday: data.targets.washingCountMonthly.target,
      encouragements: [s.keep_it_up, s.you_got_this],
      lastEarnings: lastEarnings,
      profitTitle: s.monthly_profit,
      progressValue: progressValue,
      ordersTitle: s.monthly_orders,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization instance
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeSliverAppBar(isFilter: true),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              decoration: const BoxDecoration(
                color: Color(0xffF2F4F5),
              ),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAECF0),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: const EdgeInsets.all(3),
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        labelColor: AppStyle.primaryColor,
                        unselectedLabelColor: const Color(0xFF7A7A7A),
                        labelStyle: AppTextStyle.blackW400Size14,
                        tabs: [
                          Tab(text: s.daily),
                          Tab(text: s.monthly),
                        ],
                      ),
                    ),
                    SizedBox(height: 23.h),
                    BlocBuilder<StaticsCubit, StaticsState>(
                      builder: (context, state) {
                        final cubit = context.read<StaticsCubit>();
                        final statistics = cubit.statisticsResponse?.data;

                        if (state is StaticsLoading || statistics == null) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: TabBarView(
                              children: [
                                Skeletonizer(
                                  enabled: true,
                                  child: ReportContent(
                                    data: ReportData(
                                      avgOrderText: '0',
                                      acceptanceRate: 0.0,
                                      profit: 0,
                                      ordersCount: 0,
                                      ordersGoal: 0,
                                      doneToday: 0,
                                      targetToday: 0,
                                      encouragements: [],
                                      lastEarnings: [],
                                      profitTitle: s.today_profit,
                                      progressValue: 0.0,
                                      ordersTitle: s.today_orders,
                                    ),
                                  ),
                                ),
                                Skeletonizer(
                                  enabled: true,
                                  child: ReportContent(
                                    data: ReportData(
                                      avgOrderText: '0',
                                      acceptanceRate: 0.0,
                                      profit: 0,
                                      ordersCount: 0,
                                      ordersGoal: 0,
                                      doneToday: 0,
                                      targetToday: 0,
                                      encouragements: [],
                                      lastEarnings: [],
                                      profitTitle: s.today_profit,
                                      progressValue: 0.0,
                                      ordersTitle: s.today_orders,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (state is StaticsError) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Text(
                                state.message,
                                style: AppTextStyle.blackW400Size14,
                              ),
                            ),
                          );
                        }

                        final daily = _mapToDailyReportData(statistics, s);
                        final monthly = _mapToMonthlyReportData(statistics, s);

                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            children: [
                              ReportContent(data: daily),
                              ReportContent(data: monthly),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
