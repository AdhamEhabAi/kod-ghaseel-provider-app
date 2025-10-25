import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasError;
  final bool success;
  final Function(String)? onCompleted;

  const OTPTextField({
    super.key,
    required this.controller,
    this.hasError = false,
    this.success = false,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        cursorHeight: 30.h,
        controller: controller,
        appContext: context,
        textStyle: AppTextStyle.blackW600Size34Roboto,
        length: 4,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(14.r),
          borderWidth: 1,
          inactiveFillColor: AppStyle.white,
          selectedFillColor: AppStyle.white,
          selectedColor: AppStyle.green,
          errorBorderColor: hasError
              ? Colors.red
              : success
              ? AppStyle.green
              : AppStyle.offWhite,
          inactiveColor: AppStyle.black.withValues(alpha: 0.5),
          activeColor: hasError
              ? Colors.red
              : success
              ? AppStyle.green
              : AppStyle.grey,
          activeFillColor: AppStyle.white,
          fieldHeight: 50.h,
          fieldWidth: 50.h,
        ),
        enableActiveFill: true,
        cursorColor: AppStyle.black,
        animationDuration: const Duration(milliseconds: 300),
        keyboardType: TextInputType.number,
        onChanged: (_) {},
        onCompleted: onCompleted,
        boxShadows: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10.r,
          ),
        ],
      ),
    );
  }
}
