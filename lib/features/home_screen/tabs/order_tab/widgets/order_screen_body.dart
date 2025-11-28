import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/orders/controller/orders_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';
import 'order_card.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // adjust if your path differs

class OrderScreenBody extends StatelessWidget {
  final TabController tabController;

  const OrderScreenBody({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization accessor

    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(s.orders_title, style: AppTextStyle.blackW600Size14Roboto),
                SizedBox(width: 4.w),
                BlocBuilder<OrdersCubit, OrdersState>(
                  builder: (context, state) {
                    final cubit = context.read<OrdersCubit>();
                    final index = tabController.index;
                    OrderTabType tabType;
                    switch (index) {
                      case 0:
                        tabType = OrderTabType.upcoming;
                        break;
                      case 1:
                        tabType = OrderTabType.current;
                        break;
                      case 2:
                        tabType = OrderTabType.past;
                        break;
                      default:
                        tabType = OrderTabType.upcoming;
                    }
                    final orders = cubit.getOrdersByTabType(tabType);
                    final count = orders?.data.length ?? 0;
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 7.w),
                      decoration: BoxDecoration(
                        color: AppStyle.primaryColor.withAlpha(0x1A),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        count.toString(),
                        style: AppTextStyle.primaryW600Size12,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AnimatedBuilder(
              animation: tabController,
              builder: (context, _) {
                final index = tabController.index;
                OrderTabType tabType;
                switch (index) {
                  case 0:
                    tabType = OrderTabType.upcoming;
                    break;
                  case 1:
                    tabType = OrderTabType.current;
                    break;
                  case 2:
                    tabType = OrderTabType.past;
                    break;
                  default:
                    tabType = OrderTabType.upcoming;
                }

                final cubit = context.read<OrdersCubit>();
                final orders = cubit.getOrdersByTabType(tabType);

                Widget content;
                if (state is OrdersLoading && state.tabType == tabType.name) {
                  // Create dummy order for skeleton
                  final dummyOrder = _createDummyOrder(tabType);
                  content = Skeletonizer(
                    enabled: true,
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        ...List.generate(3, (index) => Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: OrderCard(order: dummyOrder, tabType: tabType),
                            )),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  );
                } else if (state is OrdersError && state.tabType == tabType.name) {
                  content = Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.h),
                      child: Text(
                        state.message,
                        style: AppTextStyle.greyW400Size14,
                      ),
                    ),
                  );
                } else if (orders == null || orders.data.isEmpty) {
                  content = Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.h),
                      child: Text(
                        s.no_orders,
                        style: AppTextStyle.greyW400Size14,
                      ),
                    ),
                  );
                } else {
                  // Show all orders - API already filters by past/upcoming/today
                  List<Order> displayOrders = orders.data;

                  content = Column(
                    children: [
                      SizedBox(height: 8.h),
                      ...displayOrders.map((order) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: OrderCard(order: order, tabType: tabType),
                          )),
                      SizedBox(height: 8.h),
                    ],
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: content,
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Create a dummy order for skeleton loading
  Order _createDummyOrder(OrderTabType tabType) {
    String status;
    String orderStatus;
    
    switch (tabType) {
      case OrderTabType.upcoming:
        status = 'assigned';
        orderStatus = 'pending';
        break;
      case OrderTabType.current:
        status = 'in_progress';
        orderStatus = 'confirmed';
        break;
      case OrderTabType.past:
        status = 'completed';
        orderStatus = 'confirmed';
        break;
    }

    return Order(
      id: 0,
      deliveryUserId: 0,
      orderId: 0,
      status: status,
      orderDate: '2025-01-01',
      orderTime: '10:00:00',
      orderType: 'order',
      createdAt: '2025-01-01 10:00:00',
      updatedAt: '2025-01-01 10:00:00',
      deliveryName: 'Loading...',
      deliveryPhone: '0000000000',
      deliveryOnlineStatus: 'online',
      userId: 0,
      locationId: 0,
      optionalServiceIds: [],
      optionalServiceCounts: [],
      orderStatus: orderStatus,
      orderCreatedAt: '2025-01-01 10:00:00',
      serviceName: 'Loading service...',
      servicePrice: '0.00',
      serviceDescription: 'Loading description...',
      locationName: 'Loading location...',
      latitude: '0.0',
      longitude: '0.0',
      locationAddress: 'Loading address...',
      customerId: 0,
      customerName: 'Loading customer...',
      customerPhone: '0000000000',
      invoiceId: 0,
      totalBeforeDiscount: '0.00',
      discountAmount: '0.00',
      totalAfterDiscount: '0.00',
      invoicePaymentMethod: 'cash',
      invoiceStatus: 'paid',
    );
  }
}
