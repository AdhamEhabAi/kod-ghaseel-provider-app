import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/otp_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/home_screen/home_screen.dart';
import '../../features/home_screen/tabs/order_tab/order_tab.dart';
import '../../features/home_screen/tabs/profile_tab/edit_profile_screen.dart';
import '../../features/home_screen/tabs/profile_tab/help_center/help_center_screen.dart';
import '../../features/home_screen/tabs/profile_tab/help_center/question_screen.dart';
import '../../features/home_screen/tabs/profile_tab/setting/notification_setting_screen.dart';
import '../../features/home_screen/tabs/profile_tab/setting/privacy_screen.dart';
import '../../features/home_screen/tabs/profile_tab/setting/setting_screen.dart';
import '../../features/notification/filter_screen.dart';
import '../../features/notification/notification_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'app_transition.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String onboardingScreen = '/OnboardingScreen';
  static const String registerScreen = '/RegisterScreen';
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
  static const String chatScreen = '/chatScreen';
  static const String orderScreen = '/orderScreen';


  static var globalNavKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: splashScreen,
    debugLogDiagnostics: true,
    navigatorKey: globalNavKey,
    redirect: (context, state) {
      final uri = state.uri.toString();
      debugPrint("Intercepted deep link: $uri");
    },
    routes: <RouteBase>[
      GoRoute(
        path: filterScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const FilterScreen(),
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
          return ChatScreen(userName: 'adham ehab');
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
        path: registerScreen,
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const RegisterScreen(),
          transition: AppTransition.slideFromRight,
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
        pageBuilder: (context, state) => TransitionHelper.page(
          state: state,
          child: const OtpScreen(),
          transition: AppTransition.slideFromRight,
        ),
      ),
    ],
  );
}
