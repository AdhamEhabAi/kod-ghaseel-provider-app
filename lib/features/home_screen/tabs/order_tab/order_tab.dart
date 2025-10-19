import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/order_tab/widgets/order_screen_body.dart';
import '../../widgets/home_sliver_app_bar.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization accessor

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: const Color(0xffF2F4F5),
        body: CustomScrollView(
          slivers: [
            const HomeSliverAppBar(isFilter: true),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: const Color(0xffEAECF0),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TabBar(
                        padding: const EdgeInsets.all(3),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        labelColor: AppStyle.primaryColor,
                        labelStyle: AppTextStyle.greyW400Size14,
                        unselectedLabelColor: const Color(0xff7A7A7A),
                        tabs: [
                          Tab(text: s.orders_upcoming), // "القادمة"
                          Tab(text: s.orders_current),  // "الحالية"
                          Tab(text: s.orders_past),     // "السابقة"
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: const OrderScreenBody(),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
