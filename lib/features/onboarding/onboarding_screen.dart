import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/features/onboarding/widgets/button_section_onboarding.dart';
import 'package:kod_ghaseel_provider_app/features/onboarding/widgets/middle_text_onboarding.dart';

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
  bool showContent = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        startAnimation = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        showContent = true;
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
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: SvgPicture.asset(
                        Assets.topOnboarding,
                        width: size.width,
                      ),
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
                          tween: Tween(
                            begin: 80,
                            end: startAnimation ? 1 : 80,
                          ),
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          builder: (context, scale, _) {
                            return Transform.scale(
                              scale: scale,
                              alignment: Alignment.center,
                              child: SvgPicture.asset(Assets.logoSvg),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: showContent ? 1 : 0,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                child: Column(
                  spacing: 60.h,
                  children: [
                    MiddleTextOnBoarding(),
                    ButtonSectionOnBoarding(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
