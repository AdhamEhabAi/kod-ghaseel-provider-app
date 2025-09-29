import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Utilites/app_fonts/font.dart';
import '../../../Utilites/app_style/style.dart';

class OTPTextField extends StatelessWidget {
  final bool hasError;
  final bool success;
  final bool isEditPhoneNumber;
  final String? oldPhoneNumber;

  const OTPTextField({
    super.key,
    this.hasError = false,
    this.success = false,
    this.isEditPhoneNumber = false,
    this.oldPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController otpController = TextEditingController();
    final isOtpEnabled = true;

    return Directionality(
      // 🔹 Force Left-to-Right
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        cursorHeight: 30.h,
        enabled: isOtpEnabled,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا مطلوب';
          }
          return null;
        },
        controller: otpController,
        appContext: context,
        textStyle: AppTextStyle.blackW600Size34Roboto,
        length: 4,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(14.r),
          borderWidth: 1,
          activeBorderWidth: 1,
          disabledBorderWidth: 1,
          errorBorderWidth: 1,
          inactiveBorderWidth: 1,
          inactiveFillColor: AppStyle.white,
          selectedFillColor: AppStyle.white,
          selectedColor: AppStyle.green,
          errorBorderColor: hasError
              ? Colors.red
              : success
              ? AppStyle.green
              : AppStyle.grey,
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
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: false,
        ),
        boxShadows: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10.r,
          ),
        ],
        onChanged: (String v) {},
        onCompleted: (String v) async {},
      ),
    );
  }
}
