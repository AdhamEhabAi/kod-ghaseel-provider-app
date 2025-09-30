import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../widgets/home_sliver_app_bar.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00AEEF);
    const scaffold = Color(0xFFF2F4F5);
    const chipBg = Color(0xFFEFF8FF);

    return Scaffold(
      backgroundColor: scaffold,
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFEAECF0),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: const EdgeInsets.all(3),
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        labelColor: primary,
                        unselectedLabelColor: const Color(0xFF7A7A7A),
                        labelStyle: AppTextStyle.blackW400Size14,
                        tabs: const [
                          Tab(text: 'يومي'),
                          Tab(text: 'شهري'),
                        ],
                      ),
                    ),

                    SizedBox(height: 23.h),
                    _StatsBuilder(
                      builder: (ctx, stats) => Column(
                        children: [
                          // الصف الرئيسي: كارت الأرباح + كروت صغيرة يمين
                          Row(
                            textDirection: TextDirection.ltr,
                            // علشان الكارت الكبير يبقى يسار زي الصورة
                            children: [
                              // الكارت الكبير (الأرباح اليوم)
                              Expanded(
                                flex: 3,
                                child: _ProfitCard(stats: stats),
                              ),
                              SizedBox(width: 10.w),
                              // عمود الكروت الصغيرة
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _SmallStatCard(
                                      title: 'متوسط الطلب',
                                      value: '${stats.avgOrder} ريال',
                                    ),
                                    SizedBox(height: 10.h),
                                    _DonutCard(),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          // البادچات التحفيزية
                          Row(
                            children: [
                              Expanded(
                                child: _ChipInfo(
                                  text: 'واصل تمركزك!',
                                  icon: Icons.verified, // أيقونة لطيفة
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: _ChipInfo(
                                  text: 'إنت قدها، كفو! 💪',
                                  icon: Icons.emoji_events_outlined,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          // طلبات اليوم + Progress
                          _TodayOrdersCard(stats: stats),

                          SizedBox(height: 16.h),

                          // آخر الأرباح
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'آخر الأرباح',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),

                          // لستة عناصر غير قابلة للتمرير (الشاشة كلها هي اللي بتسکرول)
                          _EarningItem(
                            amount: '+25 ريال',
                            name: 'أحمد محمد',
                            subtitle: 'غسيل خارجي - 3:30 م',
                          ),
                          SizedBox(height: 8.h),
                          _EarningItem(
                            amount: '+45 ريال',
                            name: 'محمد علي',
                            subtitle: 'غسيل شامل - 2:15 م',
                          ),
                          SizedBox(height: 8.h),
                          _EarningItem(
                            amount: '+30 ريال',
                            name: 'فاطمة خالد',
                            subtitle: 'غسيل خارجي - 1:00 م',
                          ),

                          SizedBox(height: 80.h),
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

/// يقرأ التاب الحالي (يومي/شهري) ويغذي بقية الواجهة ببيانات مناسبة
class _StatsBuilder extends StatelessWidget {
  final Widget Function(BuildContext, _Stats) builder;

  const _StatsBuilder({required this.builder});

  @override
  Widget build(BuildContext context) {
    final ctrl = DefaultTabController.of(context)!;

    return AnimatedBuilder(
      animation: ctrl,
      builder: (context, _) {
        final isDaily = ctrl.index == 0;
        final stats = isDaily
            ? const _Stats(
                label: 'اليوم',
                profit: 245,
                target: 300,
                ordersDone: 10,
                ordersTarget: 12,
                acceptance: .96,
                avgOrder: 25,
              )
            : const _Stats(
                label: 'هذا الشهر',
                profit: 3845,
                target: 6000,
                ordersDone: 82,
                ordersTarget: 120,
                acceptance: .91,
                avgOrder: 29,
              );
        return builder(context, stats);
      },
    );
  }
}

class _Stats {
  final String label;
  final int profit;
  final int target;
  final int ordersDone;
  final int ordersTarget;
  final double acceptance; // 0..1
  final int avgOrder;

  const _Stats({
    required this.label,
    required this.profit,
    required this.target,
    required this.ordersDone,
    required this.ordersTarget,
    required this.acceptance,
    required this.avgOrder,
  });

  double get progressToTarget =>
      (target == 0) ? 0 : (profit / target).clamp(0, 1).toDouble();
}

/// الكارت الكبير (الخلفية داكنة + Progress لحدّف 300 ريال)
class _ProfitCard extends StatelessWidget {
  final _Stats stats;

  const _ProfitCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width*(222/390),
      height: MediaQuery.of(context).size.height*(218/844),
      decoration: BoxDecoration(
        color: const Color(0xFF192126),
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.only(top:31.h,bottom: 25.h,left: 11.w,right: 11.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Text(
                'أرباح ${stats.label}',
                style: AppTextStyle.whiteW400Size14
              ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${stats.profit}',
                style: AppTextStyle.whiteW600Size39Roboto.copyWith(fontSize: 45.sp,fontFamily: "Inter")
              ),
              SizedBox(width: 5.w,),
              Text(
                  'ريال',
                  style: AppTextStyle.whiteW400Size16Roboto.copyWith(fontSize: 23.sp)
              ),
              SizedBox(height: 11.h,),
            ],
          ),
          Text(
            'من ${stats.ordersDone} طلبات',
            style: AppTextStyle.whiteW400Size14.copyWith(color: Colors.white70)
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("300 ريال",style: AppTextStyle.whiteW600Size12Roboto,),
            ]
          ),
          SizedBox(height: 5.h,),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8.r),
                minHeight: 4.h,
                value: stats.progressToTarget,
                backgroundColor: Color(0x6b005265),
                color: AppStyle.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            ' ${(stats.progressToTarget * 100).round()}% مكتمل',
            style: AppTextStyle.whiteW500Size10,
          ),
        ],
      ),
    );
  }
}

/// كارت صغير للنصوص (متوسط الطلب)
class _SmallStatCard extends StatelessWidget {
  final String title;
  final String value;

  const _SmallStatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*(70/844),
      width: MediaQuery.of(context).size.width*(112/390),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 19.w),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  "25",
                  style: AppTextStyle.blackW700Size26
                ),
                Text(
                  "ريال",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
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

/// كارت بدونات (معدل القبول)
class _DonutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyle.primaryColorOpacity10,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("معدل القبول", style: AppTextStyle.blackW500Size13),
          SizedBox(height: 15.h),
          CircularPercentIndicator(
            startAngle: 180,
            radius: 35,
            center: Text(
              "50%",
              style: AppTextStyle.blackW600Size14Roboto.copyWith(
                fontFamily: "Lato",
              ),
            ),
            lineWidth: 10,
            percent: 0.50,
            progressColor: AppStyle.primaryColor,
            backgroundColor: Colors.white,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }
}

/// شريحة تحفيزية صغيرة
class _ChipInfo extends StatelessWidget {
  final String text;
  final IconData icon;

  const _ChipInfo({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8FF),
        borderRadius: BorderRadius.circular(14.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF38BDF8)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
                color: const Color(0xFF0F172A),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// كارت "طلبات اليوم" مع Progress
class _TodayOrdersCard extends StatelessWidget {
  final _Stats stats;

  const _TodayOrdersCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final ratio = (stats.ordersTarget == 0)
        ? 0.0
        : (stats.ordersDone / stats.ordersTarget).clamp(0, 1).toDouble();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 32.w,
                  width: 32.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFF8FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: Color(0xFF38BDF8),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'طلبات اليوم',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${stats.ordersDone}/${stats.ordersTarget}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: LinearProgressIndicator(
                    minHeight: 10.h,
                    value: ratio,
                    backgroundColor: const Color(0xFFE5E7EB),
                    color: const Color(0xFF00AEEF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// عنصر من "آخر الأرباح"
class _EarningItem extends StatelessWidget {
  final String amount, name, subtitle;

  const _EarningItem({
    required this.amount,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          // المبلغ (جانب أيسر)
          Container(
            width: 70.w,
            height: 36.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF8FF),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              amount,
              style: TextStyle(
                color: const Color(0xFF06B6D4),
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // الاسم + الوصف
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // علامة صح
          const Icon(Icons.check_circle, color: Color(0xFF10B981)),
        ],
      ),
    );
  }
}
