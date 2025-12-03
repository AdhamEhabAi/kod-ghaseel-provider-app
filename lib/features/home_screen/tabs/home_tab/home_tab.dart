import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/helper_functions.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/accepting_rate_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/balance_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/number_of_orders_container.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/order_information_card.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/widgets/user_data_section.dart';
import 'package:kod_ghaseel_provider_app/features/orders/controller/orders_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/statics/controller/statics_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Utilites/app_fonts/font.dart';
import '../../../../core/router/router.dart';
import '../../../../generated/l10n.dart';
import '../../widgets/home_sliver_app_bar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersCubit>().getOrders(
        tabType: OrderTabType.current,
        limit: 5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
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
                  BlocBuilder<StaticsCubit, StaticsState>(
                    builder: (context, state) {
                      final cubit = context.read<StaticsCubit>();
                      final statistics = cubit.statisticsResponse?.data;
                      if (statistics == null) {
                        return Skeletonizer(
                          enabled: true,
                          child: BalanceContainer(
                            amount: 0,
                            completedOrders: 0,
                          ),
                        );
                      }

                      return BalanceContainer(
                        amount: statistics.commission.today,
                        completedOrders: statistics.completedOrders.today,
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<StaticsCubit, StaticsState>(
                        builder: (context, state) {
                          final cubit = context.read<StaticsCubit>();
                          final statistics = cubit.statisticsResponse?.data;

                          if (statistics == null) {
                            return Skeletonizer(
                              enabled: true,
                              child: NumberOfOrdersContainer(
                                totalOrders: 0,
                                dailyOrders: 0,
                              ),
                            );
                          }

                          return NumberOfOrdersContainer(
                            totalOrders: statistics.completedOrders.month,
                            dailyOrders: statistics.completedOrders.today,
                          );
                        },
                      ),
                      BlocBuilder<StaticsCubit, StaticsState>(
                        builder: (context, state) {
                          final cubit = context.read<StaticsCubit>();
                          final statistics = cubit.statisticsResponse?.data;

                          if (statistics == null) {
                            return Skeletonizer(
                              enabled: true,
                              child: AcceptingRateContainer(
                                acceptanceRate: 0,
                                rating: 0,
                              ),
                            );
                          }

                          return AcceptingRateContainer(
                            acceptanceRate: statistics.acceptanceRate,
                            rating: statistics.rating.today,
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<OrdersCubit, OrdersState>(
                    builder: (context, state) {
                      final cubit = context.read<OrdersCubit>();
                      final orders = cubit.getOrdersByTabType(
                        OrderTabType.current,
                      );

                      final hasOrders =
                          orders != null && orders.data.isNotEmpty;
                      final isLoading =
                          state is OrdersLoading && state.tabType == 'current';

                      final hasOrderWithinHour = hasOrders
                          ? orders.data.any(
                              (order) => HelperFunctions.isWithinOneHour(order),
                            )
                          : false;

                      final hasOtherOrders = hasOrders
                          ? orders.data.any(
                              (order) =>
                                  !HelperFunctions.isWithinOneHour(order),
                            )
                          : false;

                      if (!hasOrders && !isLoading) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (hasOrderWithinHour || isLoading) ...[
                            SizedBox(height: 12.h),
                            Text(
                              s.currentOrder,
                              style: AppTextStyle.blackW600Size14Roboto,
                            ),
                            SizedBox(height: 12.h),
                            if (isLoading)
                              // Skeleton for UserDataSection
                              Skeletonizer(
                                enabled: true,
                                child: UserDataSection(
                                  subtitle: s.mapAddress,
                                  name: 'Loading...',
                                ),
                              )
                            else if (hasOrderWithinHour)
                              // Show order within 1 hour in UserDataSection
                              Builder(
                                builder: (context) {
                                  final orderWithinHour = orders.data
                                      .where(
                                        (order) =>
                                            HelperFunctions.isWithinOneHour(
                                              order,
                                            ),
                                      )
                                      .first;
                                  final isCompleted = HelperFunctions.isOrderCompleted(orderWithinHour);
                                  return InkWell(
                                    onTap: () {
                                      if (isCompleted) {
                                        ToastM.show(s.orderAlreadyCompleted);
                                      } else {
                                        GoRouter.of(context).push(
                                          AppRouter.serviceScreen,
                                          extra: {'order': orderWithinHour},
                                        );
                                      }
                                    },
                                    child: Stack(
                                      children: [
                                        UserDataSection(
                                          subtitle: orderWithinHour.locationAddress,
                                          name: orderWithinHour.customerName,
                                        ),
                                        if (isCompleted)
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 4.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(12.r),
                                              ),
                                              child: Text(
                                                s.completed,
                                                style: AppTextStyle.blackW500Size10.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ],
                          if (hasOtherOrders || isLoading) ...[
                            SizedBox(height: 12.h),
                            Text(
                              s.today_orders,
                              style: AppTextStyle.blackW600Size14Roboto,
                            ),
                            SizedBox(height: 6.h),
                            if (isLoading)
                              // Skeleton for OrderInformation list
                              Skeletonizer(
                                enabled: true,
                                child: Column(
                                  children: List.generate(
                                    2,
                                    (index) => Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: OrderInformation(
                                        clientName: 'Loading...',
                                        serviceDescription:
                                            s.carServiceDescription,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            else if (hasOtherOrders)
                              Column(
                                children: orders.data
                                    .where(
                                      (order) =>
                                          !HelperFunctions.isWithinOneHour(
                                            order,
                                          ),
                                    )
                                    .map((order) {
                                      final serviceDesc =
                                          HelperFunctions.getServiceDescription(
                                            order,
                                          );
                                      final isCompleted = HelperFunctions.isOrderCompleted(order);
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: OrderInformation(
                                          clientName: order.customerName,
                                          serviceDescription:
                                              serviceDesc.isNotEmpty
                                              ? serviceDesc
                                              : s.carServiceDescription,
                                          isCompleted: isCompleted,
                                          onViewPressed: () {
                                            if (isCompleted) {
                                              ToastM.show(s.orderAlreadyCompleted);
                                            } else {
                                              // Navigate to order details or service screen
                                              GoRouter.of(context).push(
                                                AppRouter.serviceScreen,
                                                extra: {'order': order},
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    })
                                    .toList(),
                              ),
                          ],
                        ],
                      );
                    },
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
