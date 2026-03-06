import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/features/auth/presentation/widgets/login_form.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [

            Positioned(
              left: 0,
              bottom: MediaQuery.of(context).size.height / 3.5,
              child: SvgPicture.asset(Assets.authStackWidget),
            ),

            Positioned(
              left: 0,
              bottom: 0,
              child: SvgPicture.asset(Assets.authStackWidgetDown),
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        /// TOP SECTION
                        Column(
                          children: [
                            SizedBox(height: 40.h),
                            SvgPicture.asset(Assets.logoSvg),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 20.h,
                              ),
                              child: Text(
                                loc.welcomeKodGhaseel,
                                style: AppTextStyle
                                    .blackW700Size18Roboto
                                    .copyWith(fontSize: 24.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              loc.enterPhoneToLogin,
                              style: AppTextStyle.blackW600Size14Roboto,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),

                        /// BOTTOM FORM
                        LoginForm(
                          onFocus: _scrollToBottom,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}