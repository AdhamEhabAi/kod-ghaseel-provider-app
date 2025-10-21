import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/accepting_rate_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/balance_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/number_of_orders_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/order_information_card.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/user_data_section.dart';

import '../../../../Utilites/app_fonts/font.dart';
import '../../../../core/router/router.dart';
import '../../../../generated/l10n.dart';
import '../../widgets/home_sliver_app_bar.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var s=S.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: CustomScrollView(
        slivers: [
          HomeSliverAppBar(),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: EdgeInsets.only(
                top: 12.h,
                bottom: 12.h,
                left: 12.w,
                right: 12.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceContainer(amount: 245, completedOrders: 12),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberOfOrdersContainer(
                        totalOrders: 125,
                        dailyOrders: 10,
                      ),
                      AcceptingRateContainer(),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    s.currentOrder,
                    style: AppTextStyle.blackW600Size14Roboto,
                  ),
                  SizedBox(height: 12.h),
                  InkWell(
                      onTap: () => GoRouter.of(context).push(AppRouter.serviceScreen),
                      child: UserDataSection(subtitle:s.mapAddress ,name: "سارة محمد",)),
                  SizedBox(height: 12.h),
                  Text(
                    s.previousOrders,
                    style: AppTextStyle.blackW600Size14Roboto,
                  ),
                  SizedBox(height: 6.h),
                  OrderInformation(
                    clientName: "ساره على",
                    serviceDescription: s.carServiceDescription,
                  ),
                  SizedBox(height: 12.h),
                  OrderInformation(
                    clientName: "منى خالد",
                    serviceDescription: s.carServiceDescription
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
