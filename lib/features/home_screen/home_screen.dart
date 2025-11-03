import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/home_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab_controller.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/order_tab/order_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/profile_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/report_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/widgets/wave_shape.dart';

import '../../Utilites/app_assets/assets.dart';
import '../../Utilites/app_style/style.dart';
import '../../core/helpers/dialog_utils.dart';
import '../../core/router/router.dart';
import 'controller/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey _bottomNavigationBarKey = GlobalKey();
  Size _bottomNavigationBarSize = Size(0, 0);

  @override
  void initState() {
    super.initState();
    _getBottomNavigationBarSize();
    HomeTabController.value.addListener(_onTabChanged);
    context.read<HomeScreenCubit>().checkSessionValidation();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getBottomNavigationBarSize());
  }
  void _onTabChanged() {
    if (_selectedIndex != HomeTabController.value.value) {
      setState(() => _selectedIndex = HomeTabController.value.value);
    }
  }
  void _getBottomNavigationBarSize() {
    final RenderBox? bottomNavigationBarRenderBox =
    _bottomNavigationBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (bottomNavigationBarRenderBox != null) {
      setState(() {
        _bottomNavigationBarSize = bottomNavigationBarRenderBox.size;
      });
    }
  }

  final List<Widget> pages=[
    HomeTab(),
    OrdersTab(),
    ReportTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final itemWidth = _bottomNavigationBarSize.width / 4;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(128), blurRadius: 10),
          ],
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,

          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                child: SizedBox(
                  height: 70.h,
                  child: BottomNavigationBar(
                    backgroundColor: AppStyle.white,
                    enableFeedback: false,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    key: _bottomNavigationBarKey,
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.homeIconSVG,
                          color: _selectedIndex == 0 ? AppStyle.primaryColor : null,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.calendarIconSVG,
                          color: _selectedIndex == 1 ? AppStyle.primaryColor : null,
                        ),
                        label: 'discount',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.activityIcon,
                          color: _selectedIndex == 2 ? AppStyle.primaryColor : null,
                        ),
                        label: 'activity',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.profileIconSVG,
                          color: _selectedIndex == 3 ? AppStyle.primaryColor : null,
                        ),
                        label: 'calendar',
                      ),

                    ],
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        HomeTabController.value.value = index;
                      });
                    },
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                bottom: 0,
                right: (itemWidth * _selectedIndex) - 30.w,
                child: const WaveShape(),
              ),
            ],
          ),
        ),
      ),
      body:BlocListener<HomeScreenCubit, HomeScreenState>(
        listener: (context, state) {
          if (state is ValidationLoadingState) {
            DialogUtils.showLoading(
              context: context,
              message: "جاري تحليل البيانات برجاء الانتظار",
            );
          } else if (state is NotValidateSession) {
            DialogUtils.hideLoading(context);
            DialogUtils.showAlert(
                context: context,
                message: "برجاء تسجيل الدخول مره اخرى",
                posAction:(){
                  GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
                  AppSharedPreferences.clear();
                },
                posActionName: "تسجيل الدخول"
            );
          }else if(state is ValidatedSession){
            DialogUtils.hideLoading(context);
          }
        },
        child: pages[_selectedIndex],
      ),
    );
  }
}