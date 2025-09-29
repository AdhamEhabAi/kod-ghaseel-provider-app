import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../../../Utilites/app_fonts/font.dart';
import '../../../Utilites/app_style/style.dart';
import '../../../core/router/router.dart';
import '../../../shared/shared_widget.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الاسم',
              style: AppTextStyle.blackW600Size16Roboto,
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              colorBorder: Color(0xffEEEEEE),
              controller: textEditingController,
              keyboardType: TextInputType.text,
              hintText: 'ادخل اسمك..',
            ),
            SizedBox(height: 20.h),

            Text(
              'رقم الهاتف',
              style: AppTextStyle.blackW600Size16Roboto,
            ),
            SizedBox(height: 10.h),

            CustomTextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              hintTextDirection: TextDirection.ltr,
              hintText: '0000...',
              colorBorder: Color(0xffEEEEEE),
              suffixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0x8acbcbcb),
                    width: 1.5.w,
                  ),
                  color: Color(0x66eeeeee),
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
                  'احصل على رمز التحقق',
                  style: AppTextStyle.whiteW600Size16Roboto,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لديك حساب بالفعل؟',
                  style: AppTextStyle.blackW400Size12Roboto,
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: (){
                    GoRouter.of(context).push(AppRouter.loginScreen);
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: AppTextStyle.blackW600Size14Roboto.copyWith(
                      fontSize: 12.sp,
                      color: Color(0xFF01D0FE),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF01D0FE),
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
