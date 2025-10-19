import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.name,
              style: AppTextStyle.blackW600Size16Roboto,
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              colorBorder: const Color(0xffEEEEEE),
              controller: textEditingController,
              keyboardType: TextInputType.text,
              hintText: loc.enterYourName,
            ),
            SizedBox(height: 20.h),

            Text(
              loc.phoneNumber,
              style: AppTextStyle.blackW600Size16Roboto,
            ),
            SizedBox(height: 10.h),

            CustomTextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              hintTextDirection: TextDirection.ltr,
              hintText: loc.phoneNumberHint,
              colorBorder: const Color(0xffEEEEEE),
              suffixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0x8acbcbcb),
                    width: 1.5.w,
                  ),
                  color: const Color(0x66eeeeee),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text('+966', style: AppTextStyle.blackW600Size16Roboto),
              ),
            ),

            SizedBox(height: 30.h),

            Center(
              child: DefaultButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.otpScreen);
                },
                backgroundColorButton: AppStyle.primaryColor,
                width: 250.w,
                borderRadius: BorderRadius.circular(50.r),
                titleWidget: Text(
                  loc.getVerificationCode,
                  style: AppTextStyle.whiteW600Size16Roboto,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.alreadyHaveAccount,
                  style: AppTextStyle.blackW400Size12Roboto,
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.loginScreen);
                  },
                  child: Text(
                    loc.login,
                    style: AppTextStyle.blackW600Size14Roboto.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xFF01D0FE),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF01D0FE),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
