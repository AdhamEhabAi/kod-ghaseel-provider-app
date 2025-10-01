import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/body_app.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';
import '../../Utilites/app_assets/assets.dart';
import '../../Utilites/app_fonts/font.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return BodyApp(
      title: 'تسجيل الدخول',
      content: Padding(
        padding: AppStyle.paddingContainerHome,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اهلاً بعودتك,',
              style: AppTextStyle.primaryW600Size12.copyWith(fontSize: 24.sp),
            ),
            SizedBox(height: 10.h),
            Text(
              'مرحباً بعودتك، أدخل رقم هاتفك للمتابعة.',
              style: AppTextStyle.blackW500Size13,
            ),
            SizedBox(height: 50.h),
            Center(child: Image.asset(Assets.loginImage)),
            SizedBox(height: 30.h),

            CustomTextFormField(
              radius: 41.r,
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              hintTextDirection: TextDirection.ltr,
              hintText: '0000...',
              colorBorder: Color(0xffEEEEEE),
              suffixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0x8acbcbcb), width: 1.5.w),
                  color: Color(0x66eeeeee),
                  borderRadius: BorderRadius.circular(41.r),
                ),
                child: Text('+966', style: AppTextStyle.blackW600Size16Roboto),
              ),
            ),
            Spacer(),
            Center(
              child: DefaultButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.otpScreen);
                },
                backgroundColorButton: AppStyle.primaryColor,
                height: 60.h,
                borderRadius: BorderRadius.circular(50.r),
                titleWidget: Text(
                  'احصل على رمز التحقق',
                  style: AppTextStyle.whiteW600Size16Roboto,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRouter.registerScreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ليس لديك حساب؟',
                    style: AppTextStyle.blackW400Size12Roboto,
                  ),
                  Text(
                    'إنشاء حساب',
                    style: AppTextStyle.blackW400Size12Roboto.copyWith(
                      color: AppStyle.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppStyle.primaryColor,
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
