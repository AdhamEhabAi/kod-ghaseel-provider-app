import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.textEditingController});

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

            SizedBox(height: 100.h),

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
          ],
        ),
      ),
    );
  }
}
