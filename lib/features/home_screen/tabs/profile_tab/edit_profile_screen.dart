import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/widgets/TextFiledTitle.dart';


import '../../../../Utilites/app_assets/assets.dart';
import '../../../../Utilites/app_fonts/font.dart';
import '../../../../Utilites/app_style/style.dart';
import '../../../../core/widgets/setting_app_bar.dart';
import '../../../../shared/shared_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController(
    text: 'سارة محمد',
  );
  TextEditingController emailController = TextEditingController(
    text: 'example@gmail.com',
  );
  TextEditingController phoneController = TextEditingController(
    text: '81234567890',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F7),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 8),
              SettingAppBar(title: 'حسابي الشخصي'),
              SizedBox(height: 45.h),
              SizedBox(
                height: 110.h,
                width: 110.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBEEAF7), // light teal/blue
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 54)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppStyle.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppStyle.white, width: 4),
                        ),
                        child: SvgPicture.asset(
                          Assets.cameraIconSVG,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFiledTitle('اسم المستخدم'),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        colorBorder: AppStyle.textFieldBorderColor,
                        style: AppTextStyle.blackW600Size16Roboto,
                        color: Colors.transparent,
                        radius: 16.r,
                        prefixIcon: SvgPicture.asset(
                          Assets.personIconSVG,
                          fit: BoxFit.scaleDown,
                        ),
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 12.h),
                      TextFiledTitle('عنوان البريد'),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        textDirection: TextDirection.ltr,
                        colorBorder: AppStyle.textFieldBorderColor,
                        style: AppTextStyle.blackW600Size16Roboto,
                        color: Colors.transparent,
                        radius: 16.r,
                        suffixIcon: Icon(Icons.email),
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 12.h),
                      TextFiledTitle('رقم الهاتف'),
                      SizedBox(height: 12.h),
                      CustomTextFormField(
                        color: Colors.transparent,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        colorBorder: AppStyle.textFieldBorderColor,
                        suffixIcon: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '966+',
                            style: AppTextStyle.blackW400Size16Roboto.copyWith(
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 70.h),
                      Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 40.w),
                          child: DefaultButton(
                            backgroundColorButton: AppStyle.primaryColorOpacity10,
                            onPressed: (){
                              GoRouter.of(context).pop();
                            },
                            borderRadius: BorderRadius.circular(50.r),
                            titleWidget: Text('حفظ',style: AppTextStyle.blackW600Size16Roboto.copyWith(color: Color(0xFF01D0FE)),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



