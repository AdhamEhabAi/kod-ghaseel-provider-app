import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../Utilites/app_assets/assets.dart';
import '../../core/router/router.dart';


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
    Future.delayed(const Duration(milliseconds:1500 ), () {
      setState(() {
        startAnimation = true;
      });
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        GoRouter.of(context).go(AppRouter.onboardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 1,
            end: startAnimation ? 45 : 1,
          ),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          builder: (context, scale, _) {
            return OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Assets.logoSvg,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
