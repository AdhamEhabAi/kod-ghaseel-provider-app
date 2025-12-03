import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/home_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab_controller.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/order_tab/order_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/profile_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/report_tab/report_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/widgets/wave_shape.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/statics/controller/statics_cubit.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../Utilites/app_assets/assets.dart';
import '../../Utilites/app_style/style.dart';
import '../../core/helpers/dialog_utils.dart';
import '../../core/router/router.dart';
import '../orders/controller/orders_cubit.dart';
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
  DateTime? _lastBackPress;
  @override
  void initState() {
    super.initState();
    _getBottomNavigationBarSize();
    HomeTabController.value.addListener(_onTabChanged);
    context.read<HomeScreenCubit>().checkSessionValidation();

    // Initialize location service and start streaming when HomeScreen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBottomNavigationBarSize();
      print('🗺️ [HomeScreen] Initializing location service');
      context.read<ServiceCubit>().initializeLocation().then((_) {
        print('🗺️ [HomeScreen] Location initialized, starting stream');
        context.read<ServiceCubit>().startLocationStream();
      });
    });
  }

  @override
  void dispose() {
    // Don't stop location stream here - let it run in background
    // It will be stopped when app closes or user logs out
    HomeTabController.value.removeListener(_onTabChanged);
    super.dispose();
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

    return PopScope(
      canPop: false, // we handle back button manually
      onPopInvokedWithResult: (didPop, t) {
        if (didPop) return;

        final now = DateTime.now();
        const dur = Duration(seconds: 2);

        if (_lastBackPress == null || now.difference(_lastBackPress!) > dur) {
          _lastBackPress = now;
          ToastM.show(S.of(context).pressBackAgainToExit);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
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
                          context.read<HomeScreenCubit>().loadUser();
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
        body:CustomMaterialIndicator(
          indicatorBuilder: (context, controller) {
            return AppLoader();
          },
          onRefresh: () {
            return onRefresh();
          },
          child: BlocListener<HomeScreenCubit, HomeScreenState>(
            listener: (context, state)async {
              if (state is ValidationLoadingState) {
                DialogUtils.showLoading(
                  context: context,
                  message: "جاري تحليل البيانات برجاء الانتظار",
                );
              } else if (state is NotValidateSession) {
                DialogUtils.hideLoading(context);
                // Stop location stream when session is invalid
                context.read<ServiceCubit>().stopLocationStream();
                DialogUtils.showAlert(
                    context: context,
                    message: state.message,
                    posAction:(){
                      GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
                      AppSharedPreferences.clear();
                    },
                    posActionName: "تسجيل الدخول"
                );
              }else if(state is ValidatedSession) {
                DialogUtils.hideLoading(context);
                var fcmToken = await context.read<AuthCubit>().getFcmToken();
                context.read<AuthCubit>().updateFcmToken(fcmToken??"");
                context.read<HomeScreenCubit>().getHomeBanners();
                context.read<HomeScreenCubit>().getProviderStatus();
                context.read<StaticsCubit>().getStatistics();

                // Ensure location stream is running after session validation
                // (It might have been started in initState, but ensure it's running)
                final serviceState = context.read<ServiceCubit>().state;
                if (serviceState is! ServiceLocationStreamActive &&
                    serviceState is! ServiceLocationLoading) {
                  // If location is not already initialized, initialize it
                  context.read<ServiceCubit>().initializeLocation().then((_) {
                    context.read<ServiceCubit>().startLocationStream();
                  });
                }
              }
            },
            child: pages[_selectedIndex],
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh()async {
    await context.read<HomeScreenCubit>().getHomeBanners();
    await context.read<HomeScreenCubit>().getProviderStatus();
    await context.read<StaticsCubit>().getStatistics();
    context.read<OrdersCubit>().getOrders(
      tabType: OrderTabType.current,
      limit: 5,
    );
  }
}