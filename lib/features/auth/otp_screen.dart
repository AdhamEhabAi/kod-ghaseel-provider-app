import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/widgets/otp_text_field_widget.dart';

import '../../Utilites/app_assets/assets.dart';
import '../../Utilites/app_fonts/font.dart';
import '../../Utilites/app_style/style.dart';
import '../../core/router/router.dart';
import '../../generated/l10n.dart';
import '../../shared/shared_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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

                    // 🔸 Title (centered text)
                    Expanded(
                      child: Text(
                        loc.enterCode,
                        style: AppTextStyle.blackW600Size28Roboto,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // ➡️ Invisible spacer to balance the layout visually
                    SizedBox(width: 24.w), // same width as icon for perfect centering
                  ],
                ),
              ),
            ),
            SizedBox(height: 220.h,),
            Padding(
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
          ],
        ),
      ),
    );
  }
}
