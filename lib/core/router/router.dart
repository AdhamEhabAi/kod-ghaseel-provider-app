import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/presentation/login_screen.dart';
import 'package:kod_ghaseel_provider_app/features/auth/presentation/otp_screen.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/filter/filter_home_screen.dart';
import 'package:kod_ghaseel_provider_app/features/orders/data/models/orders_response.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/service_progress_screen.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/service_screen.dart';

import '../../features/chat/chat_screen.dart';
import '../../features/home_screen/home_screen.dart';
import '../../features/home_screen/tabs/order_tab/order_tab.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/delete_account_screen.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/edit_profile_screen.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/help_center/help_center_screen.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/help_center/question_screen.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/setting/notification_setting_screen.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/setting/privacy_screen.dart';
import '../../features/home_screen/tabs/profile_tab/presentaion/setting/setting_screen.dart';
import '../../features/notification/filter_screen.dart';
import '../../features/notification/notification_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'app_transition.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String onboardingScreen = '/OnboardingScreen';
  static const String loginScreen = '/LoginScreen';
  static const String otpScreen = '/OtpScreen';
  static const String homeScreen = '/HomeScreen';

  static const String notificationScreen = '/NotificationScreen';
  static const String questionScreen = '/questionScreen';
  static const String notificationSettingScreen = '/notificationSettingScreen';
  static const String privacyScreen = '/privacyScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String settingScreen = '/settingScreen';
  static const String helpCenterScreen = '/helpCenterScreen';
  static const String filterScreen = '/filterScreen';
  static const String filterHomeScreen = '/FilterHomeScreen';
  static const String chatScreen = '/chatScreen';
  static const String orderScreen = '/orderScreen';
  static const String serviceScreen = '/serviceScreen';
  static const String serviceProgressScreen = '/ServiceProgressScreen';
  static const String deleteAccountScreen = '/deleteAccountScreen';

  static var globalNavKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: splashScreen,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: globalNavKey,
    redirect: (context, state) {
      final uri = state.uri.toString();
      debugPrint("Intercepted deep link: $uri");
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: deleteAccountScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const DeleteAccountScreen(),
          transition: AppTransition.slideFromRight,
        ),
      ),
      GoRoute(
        path: filterScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const FilterScreen(),
          transition: AppTransition.fade,
        ),
      ),
      GoRoute(
        path: serviceScreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final order = extra['order'] as Order?;

          return TransitionHelper.page(
            state: state,
            child: ServiceScreen(order: order),
            transition: AppTransition.fade,
          );
        },
      ),
      GoRoute(
        path: serviceProgressScreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final orderId = extra['orderId'] as int?;

          return TransitionHelper.page(
            state: state,
            child: ServiceProgressScreen(orderId: orderId),
            transition: AppTransition.fade,
          );
        },
      ),
      GoRoute(
        path: filterHomeScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const FilterHomeScreen(),
          transition: AppTransition.fade,
        ),
      ),
      GoRoute(
        path: helpCenterScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child:  HelpCenterScreen(),
          transition: AppTransition.scale,
        ),
      ),

      GoRoute(
        path: questionScreen,
        builder: (BuildContext context, GoRouterState state) {
          return QuestionScreen();
        },
      ),
      GoRoute(
        path: privacyScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const PrivacyScreen(),
          transition: AppTransition.scale,
        ),
      ),

      GoRoute(
        path: notificationSettingScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child:  NotificationSettingScreen(),
          transition: AppTransition.scale,
        ),
      ),
      GoRoute(
        path: settingScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child:  SettingScreen(),
          transition: AppTransition.scale,
        ),
      ),

      GoRoute(
        path: chatScreen,
        builder: (BuildContext context, GoRouterState state) {
          return ChatScreen(userName: 'adham ehab',userId: "9",);
        },
      ),
      GoRoute(
        path: notificationScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child:  NotificationScreen(),
          transition: AppTransition.slideFromRight,
        ),
      ),

      GoRoute(
        path: splashScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: orderScreen,
        builder: (BuildContext context, GoRouterState state) {
          return  OrdersTab();
        },
      ),
      GoRoute(
        path: editProfileScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child:  EditProfileScreen(),
          transition: AppTransition.scale,
        ),
      ),

      GoRoute(
        path: onboardingScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const OnboardingScreen(),
            transitionDuration: const Duration(seconds: 2),
            reverseTransitionDuration: const Duration(seconds: 2),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          );
        },
      ),

      GoRoute(
        path: homeScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const HomeScreen(),
          transition: AppTransition.slideFromBottom,
        ),
      ),

      GoRoute(
        path: loginScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const LoginScreen(),
          transition: AppTransition.slideFromRight,
        ),
      ),
      GoRoute(
        path: otpScreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final phone = extra['phone'] as String? ?? '';

          return TransitionHelper.page(
            state: state,
            child: OtpScreen(
              phone: phone,
            ),
            transition: AppTransition.slideFromRight,
          );
        },
      ),
    ],
  );
}
