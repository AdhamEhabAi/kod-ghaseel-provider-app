import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/features/onboarding/widgets/button_section_onboarding.dart';
import 'package:kod_ghaseel_provider_app/features/onboarding/widgets/middle_text_onboarding.dart';

import '../../Utilites/app_assets/assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _fadeAnimation;
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        startAnimation = true;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF01D0FE), Color(0xFF017D98), Color(0xFF009CBF)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TopOnboardingWidget(size: size, startAnimation: startAnimation),
              SizedBox(height: 10.h),
              Column(
                spacing: 30.h,
                children: [MiddleTextOnBoarding(), ButtonSectionOnBoarding()],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  Assets.bottomWaveOnboarding,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopOnboardingWidget extends StatelessWidget {
  const TopOnboardingWidget({
    super.key,
    required this.size,
    required this.startAnimation,
  });

  final Size size;
  final bool startAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -20.w,
            left: 0,
            right: 0,
            child: SvgPicture.asset(Assets.topOnboarding),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(Assets.topWaveOnboarding),
          ),
          Positioned(
            top: 100.h,
            left: 0,
            right: 0,
            child: AnimatedAlign(
              alignment: startAnimation
                  ? Alignment.topCenter
                  : Alignment.center,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 80, end: startAnimation ? 1 : 80),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                builder: (context, scale, _) {
                  return Transform.scale(
                    scale: scale,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      Assets.logoSvg,
                      width: 120.w,
                      height: 120.w,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
