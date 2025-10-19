import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/widgets/otp_text_field_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Future.delayed(
                  const Duration(milliseconds: 300),
                      () => GoRouter.of(context).pop(),
                );
              },
              child: SvgPicture.asset(Assets.chevronBackward),
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          loc.enterCode,
          style: AppTextStyle.blackW600Size28Roboto,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const OTPTextField(),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc.didNotReceiveCode,
                      style: AppTextStyle.blackW400Size14Roboto.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Add resend OTP functionality
                      },
                      child: Text(
                        loc.resendCode,
                        style: AppTextStyle.blackW400Size14Roboto.copyWith(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            DefaultButton(
              width: 250.w,
              onPressed: () {
                GoRouter.of(context).push(AppRouter.homeScreen);
              },
              backgroundColorButton: AppStyle.primaryColor,
              borderRadius: BorderRadius.circular(50.r),
              titleWidget: Text(
                loc.login,
                style: AppTextStyle.whiteW600Size16Roboto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
