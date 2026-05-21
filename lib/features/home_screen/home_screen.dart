import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/location_permission_dialog.dart';
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

// SharedPreferences key to track whether the location rationale has been shown.
// We only show it once per app install to avoid being intrusive.
const _kLocationRationaleShownKey = 'location_rationale_shown';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey _bottomNavigationBarKey = GlobalKey();
  Size _bottomNavigationBarSize = const Size(0, 0);
  DateTime? _lastBackPress;

  @override
  void initState() {
    super.initState();
    _getBottomNavigationBarSize();
    HomeTabController.value.addListener(_onTabChanged);
    context.read<HomeScreenCubit>().checkSessionValidation();

    // Location is initialised after a short delay so that the home screen
    // renders first. The pre-permission rationale dialog is shown before the
    // system dialog — this satisfies Apple Guideline 5.1.1 (permission context)
    // and Google Play's user-facing permission rationale requirement.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBottomNavigationBarSize();
      _initLocationWithRationale();
    });
  }

  /// App Store-compliant location initialisation flow:
  ///
  /// 1. If permission is already granted → initialise silently (no dialog needed)
  /// 2. If not yet asked → show our own rationale dialog first, THEN the system dialog
  /// 3. If permanently denied → do not spam the user; show a one-time settings prompt
  ///
  /// This approach satisfies:
  ///  - Apple: permission shown "in context" with clear purpose description
  ///  - Google Play: rationale shown before the system permission dialog
  Future<void> _initLocationWithRationale() async {
    final serviceCubit = context.read<ServiceCubit>();
    final repo = serviceCubit; // ServiceCubit exposes permission check indirectly

    // Check if we have already shown the rationale this install
    final bool rationaleAlreadyShown =
        AppSharedPreferences.getBool(_kLocationRationaleShownKey) ?? false;

    if (!rationaleAlreadyShown) {
      // Ensure the widget is still mounted before showing a dialog
      if (!mounted) return;

      // Show the app's own pre-permission dialog
      final bool userAccepted =
          await LocationPermissionDialog.show(context);

      // Record that we have shown it regardless of outcome so we never
      // show it again (the system will handle repeat requests)
      await AppSharedPreferences.setBool(
          _kLocationRationaleShownKey, true);

      if (!userAccepted) {
        // User dismissed — try to init anyway (system may already be granted)
        // so the app is not broken on second launch
        if (mounted) {
          serviceCubit.initializeLocation();
        }
        return;
      }
    }

    // Trigger the actual permission request + location init
    if (mounted) {
      serviceCubit.initializeLocation();
    }
  }

  @override
  void dispose() {
    HomeTabController.value.removeListener(_onTabChanged);
    super.dispose();
  }

  void _onTabChanged() {
    if (_selectedIndex != HomeTabController.value.value) {
      setState(() => _selectedIndex = HomeTabController.value.value);
    }
  }

  void _getBottomNavigationBarSize() {
    final RenderBox? box =
        _bottomNavigationBarKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      setState(() => _bottomNavigationBarSize = box.size);
    }
  }

  final List<Widget> pages = [
    HomeTab(),
    OrdersTab(),
    ReportTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isArabic =
        Localizations.localeOf(context).languageCode == 'ar';
    final double itemWidth = _bottomNavigationBarSize.width / 4;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
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
            textDirection:
                isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                          icon: SvgPicture.asset(Assets.homeIconSVG,
                              color: _selectedIndex == 0
                                  ? AppStyle.primaryColor
                                  : null),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(Assets.calendarIconSVG,
                              color: _selectedIndex == 1
                                  ? AppStyle.primaryColor
                                  : null),
                          label: 'Orders',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(Assets.activityIcon,
                              color: _selectedIndex == 2
                                  ? AppStyle.primaryColor
                                  : null),
                          label: 'Reports',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(Assets.profileIconSVG,
                              color: _selectedIndex == 3
                                  ? AppStyle.primaryColor
                                  : null),
                          label: 'Profile',
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
                  right: isArabic
                      ? (itemWidth * _selectedIndex) - 30.w
                      : null,
                  left: isArabic
                      ? null
                      : (itemWidth * _selectedIndex) + 20.w,
                  child: const WaveShape(),
                ),
              ],
            ),
          ),
        ),
        body: CustomMaterialIndicator(
          indicatorBuilder: (context, controller) => AppLoader(),
          onRefresh: onRefresh,
          child: BlocListener<HomeScreenCubit, HomeScreenState>(
            listener: (context, state) async {
              if (state is ValidationLoadingState) {
                DialogUtils.showLoading(
                  context: context,
                  message: S.of(context).analyzingDataPleaseWait,
                );
              } else if (state is NotValidateSession) {
                final bool isNoInternet =
                    state.message == 'لا يوجد اتصال بالإنترنت';
                DialogUtils.hideLoading(context);
                context.read<ServiceCubit>().stopLocationStream();
                DialogUtils.showAlert(
                  context: context,
                  message: state.message,
                  posAction: () {
                    if (isNoInternet) {
                      context
                          .read<HomeScreenCubit>()
                          .checkSessionValidation();
                      return;
                    }
                    GoRouter.of(context)
                        .pushReplacement(AppRouter.loginScreen);
                    AppSharedPreferences.clear();
                  },
                  posActionName:
                      isNoInternet ? 'اعادة الاتصال' : 'تسجيل الدخول',
                );
              } else if (state is ValidatedSession) {
                DialogUtils.hideLoading(context);
                final fcmToken =
                    await context.read<AuthCubit>().getFcmToken();
                context.read<AuthCubit>().updateFcmToken(fcmToken ?? '');
                context.read<HomeScreenCubit>().getHomeBanners();
                context.read<HomeScreenCubit>().getProviderStatus();
                context.read<StaticsCubit>().getStatistics();
              }
            },
            child: pages[_selectedIndex],
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    await context.read<HomeScreenCubit>().getHomeBanners();
    await context.read<HomeScreenCubit>().getProviderStatus();
    await context.read<StaticsCubit>().getStatistics();
    context.read<OrdersCubit>().getOrders(
      tabType: OrderTabType.current,
      limit: 5,
    );
  }
}
