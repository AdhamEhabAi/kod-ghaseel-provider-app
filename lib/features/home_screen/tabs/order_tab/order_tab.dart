import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/order_tab/widgets/order_screen_body.dart';
import 'package:kod_ghaseel_provider_app/features/orders/controller/orders_cubit.dart';
import '../../widgets/home_sliver_app_bar.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_onTabChanged);
    // Fetch initial orders for first tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchOrdersForTab(0);
    });
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      _fetchOrdersForTab(_tabController.index);
    }
  }

  void _fetchOrdersForTab(int index) {
    final cubit = context.read<OrdersCubit>();
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

    // Only fetch if we don't have orders for this tab
    final existingOrders = cubit.getOrdersByTabType(tabType);
    if (existingOrders == null) {
      cubit.getOrders(tabType: tabType, limit: 5);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // <-- localization accessor

    return Scaffold(
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
                      controller: _tabController,
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
                        Tab(text: s.orders_current), // "الحالية"
                        Tab(text: s.orders_past), // "السابقة"
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: OrderScreenBody(tabController: _tabController),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
