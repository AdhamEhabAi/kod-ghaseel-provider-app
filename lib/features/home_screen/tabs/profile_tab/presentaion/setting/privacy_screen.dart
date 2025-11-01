import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/setting/widgets/privacy_card.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

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
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingAppBar(title: s.privacy_title),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: s.search_hint,
                      controller: searchCtrl,
                      colorBorder: const Color(0xffDADADA),
                      radius: 24.r,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                    SizedBox(height: 22.h),
                    PolicyCard(title: s.privacy_policy),
                    SizedBox(height: 22.h),
                    PolicyCard(title: s.terms_conditions),
                    SizedBox(height: 22.h),
                    PolicyCard(title: s.refund_cancellation_policy),
                    SizedBox(height: 22.h),
                    PolicyCard(title: s.cookies_policy),
                    SizedBox(height: 22.h),
                    PolicyCard(title: s.user_agreement),
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
