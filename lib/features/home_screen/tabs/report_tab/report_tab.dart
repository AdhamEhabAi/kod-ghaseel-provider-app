import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/widgets/report_content.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/widgets/home_sliver_app_bar.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- added localization import

import 'data/model.dart';

class ReportTab extends StatelessWidget {
  const ReportTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization instance

    final daily = ReportData(
      avgOrderText: '25',
      acceptanceRate: 0.96,
      profit: 245,
      ordersCount: 10,
      ordersGoal: 300,
      doneToday: 10,
      targetToday: 12,
      encouragements: [s.keep_it_up, s.you_got_this],
      lastEarnings: [
        EarningRow(amount: '+25', name: 'أحمد محمد', subtitle: s.service_example('غسيل خارجي', '3:30 م')),
        EarningRow(amount: '+45', name: 'محمد علي', subtitle: s.service_example('غسيل شامل', '2:15 م')),
        EarningRow(amount: '+30', name: 'فاطمة خالد', subtitle: s.service_example('غسيل خارجي', '1:00 م')),
      ],
    );

    final monthly = ReportData(
      avgOrderText: '25',
      acceptanceRate: 0.96,
      profit: 6125,
      ordersCount: 250,
      ordersGoal: 650,
      doneToday: 250,
      targetToday: 300,
      encouragements: [s.keep_it_up, s.you_got_this],
      lastEarnings: [
        EarningRow(amount: '+25', name: 'أحمد محمد', subtitle: s.service_example('غسيل خارجي', '3:30 م')),
        EarningRow(amount: '+45', name: 'محمد علي', subtitle: s.service_example('غسيل شامل', '2:15 م')),
        EarningRow(amount: '+25', name: 'يوسف نبيل', subtitle: s.service_example('غسيل خارجي', '1:00 م')),
      ],
    );

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
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          ReportContent(data: daily),
                          ReportContent(data: monthly),
                        ],
                      ),
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
