import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/setting/widgets/privacy_card.dart';

import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';
import '../../../../../../shared/shared_widget.dart';


class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final TextEditingController searchCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingAppBar(title: 'الخصوصية'),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "ابحث عن ما يدور ببالك.......",
                      controller: searchCtrl,
                      colorBorder: Color(0xffDADADA),
                      radius: 24.r,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    PolicyCard(title: "سياسة الخصوصية"),
                    SizedBox(height: 22.h),
                    PolicyCard(title: "الشروط والأحكام"),
                    SizedBox(height: 22.h),
                    PolicyCard(title: "سياسة الاسترداد والإلغاء"),
                    SizedBox(height: 22.h),
                    PolicyCard(title: "سياسة ملفات الارتباط"),
                    SizedBox(height: 22.h),
                    PolicyCard(title: "اتفاقية الاستخدام"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

