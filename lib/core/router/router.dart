import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String onboardingScreen = '/OnboardingScreen';
  static const String registerScreen = '/RegisterScreen';
  static const String loginScreen = '/LoginScreen';
  static const String otpScreen = '/OtpScreen';
  static const String homeScreen = '/HomeScreen';


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

    ],
  );
}
