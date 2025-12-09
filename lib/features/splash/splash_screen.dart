import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/models/login_response.dart'; // contains User

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        startAnimation = true;
      });
    });

    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = await getSavedUser();

    if (!mounted) return;

    if (user != null) {
      // Check if user was in service progress screen
      final serviceProgressOrderId = AppSharedPreferences.getInt(
        SharedPreferencesKeys.serviceProgressOrderId,
      );

      if (serviceProgressOrderId != null) {
        // Navigate to service progress screen with stored orderId
        GoRouter.of(context).go(
          AppRouter.serviceProgressScreen,
          extra: {'orderId': serviceProgressOrderId},
        );
      } else {
        // Navigate to home screen
        GoRouter.of(context).go(AppRouter.homeScreen);
      }
    } else {
      GoRouter.of(context).go(AppRouter.onboardingScreen);
    }
  }

  Future<User?> getSavedUser() async {
    try {
      final userJsonString = AppSharedPreferences.getString(
        SharedPreferencesKeys.userModel,
      );

      if (userJsonString == null || userJsonString.isEmpty) {
        return null;
      }

      final Map<String, dynamic> userMap =
      jsonDecode(userJsonString) as Map<String, dynamic>;
      final user = User.fromJson(userMap);
      return user;
    } catch (e) {
      debugPrint('❌ Error loading user: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1, end: startAnimation ? 45 : 1),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          builder: (context, scale, _) {
            return OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.center,
                child: SvgPicture.asset(Assets.logoSvg),
              ),
            );
          },
        ),
      ),
    );
  }
}
