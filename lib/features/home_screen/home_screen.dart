import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:kod_ghaseel_provider_app/core/widgets/location_permission_dialog.dart';
import 'package:kod_ghaseel_provider_app/features/notification/widgets/notification_permission_sheet/show_notification_permission.dart';
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
    });
  }

  // ── Location permission flow ───────────────────────────────────────────────
  //
  // Step 1 — Foreground ("While Using"):
  //   • Already granted → init silently, jump to step 2.
  //   • Permanently denied → stop; respect user's choice.
  //   • Not yet decided → show LocationPermissionDialog, then OS dialog on Accept.
  //
  // Step 2 — Background ("Allow All the Time", Android only):
  //   • Requested in ServiceScreen.initState() when the provider opens a job,
  //     not here. Keeps the permission request in the correct context.
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> _initLocationWithRationale() async {
    final serviceCubit = context.read<ServiceCubit>();

    // ── Step 1: foreground permission ─────────────────────────────────────
    final ph.PermissionStatus fgStatus =
        await ph.Permission.locationWhenInUse.status;

    if (fgStatus.isPermanentlyDenied) return;

    if (fgStatus.isGranted || fgStatus.isLimited) {
      // Already have foreground — initialise silently then start streaming.
      if (!mounted) return;
      await serviceCubit.initializeLocation();
      if (mounted) await serviceCubit.startLocationStream();
      return;
    }

    // Not yet decided — show our rationale dialog before the OS dialog.
    if (!mounted) return;
    final bool fgAccepted = await LocationPermissionDialog.show(context);
    if (!fgAccepted || !mounted) return;

    // User tapped Allow → immediately trigger the OS "While Using" dialog.
    // We call request() here directly so the native dialog is the immediate
    // result of the button tap. initializeLocation() is called only AFTER the
    // permission is already granted, so it never triggers a second OS dialog.
    final ph.PermissionStatus requestedStatus =
        await ph.Permission.locationWhenInUse.request();
    if (!requestedStatus.isGranted && !requestedStatus.isLimited) return;

    // Permission was just granted — init location then start the 30 s stream.
    if (!mounted) return;
    await serviceCubit.initializeLocation();
    if (mounted) await serviceCubit.startLocationStream();
  }

  /// Shows the notification rationale bottom sheet once if permission has not
  /// yet been decided. Called before getFcmToken() so the OS dialog is always
  /// preceded by an in-app explanation (Apple Guideline 5.1.1).
  Future<void> _showNotificationRationaleIfNeeded() async {
    if (!mounted) return;
    final status = await ph.Permission.notification.status;
    if (status.isGranted || status.isPermanentlyDenied) return;
    if (!mounted) return;
    await showNotificationPermission(context);
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
        _bottomNavigationBarKey.currentContext?.findRenderObject()
            as RenderBox?;
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
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
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
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
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
                            color: _selectedIndex == 0
                                ? AppStyle.primaryColor
                                : null,
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            Assets.calendarIconSVG,
                            color: _selectedIndex == 1
                                ? AppStyle.primaryColor
                                : null,
                          ),
                          label: 'Orders',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            Assets.activityIcon,
                            color: _selectedIndex == 2
                                ? AppStyle.primaryColor
                                : null,
                          ),
                          label: 'Reports',
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            Assets.profileIconSVG,
                            color: _selectedIndex == 3
                                ? AppStyle.primaryColor
                                : null,
                          ),
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
                  right: isArabic ? (itemWidth * _selectedIndex) - 30.w : null,
                  left: isArabic ? null : (itemWidth * _selectedIndex) + 20.w,
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
                      context.read<HomeScreenCubit>().checkSessionValidation();
                      return;
                    }
                    GoRouter.of(context).pushReplacement(AppRouter.loginScreen);
                    AppSharedPreferences.clear();
                  },
                  posActionName: isNoInternet
                      ? 'اعادة الاتصال'
                      : 'تسجيل الدخول',
                );
              } else if (state is ValidatedSession) {
                DialogUtils.hideLoading(context);
                await _showNotificationRationaleIfNeeded();
                final fcmToken = await context.read<AuthCubit>().getFcmToken();
                await context.read<AuthCubit>().updateFcmToken(fcmToken ?? '');
                await context.read<HomeScreenCubit>().getHomeBanners();
                await context.read<HomeScreenCubit>().getProviderStatus();
                await context.read<StaticsCubit>().getStatistics();
                _initLocationWithRationale();
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
