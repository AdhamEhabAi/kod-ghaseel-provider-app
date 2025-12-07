import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/setting/widgets/privacy_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/network/api_endpoints.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';
import '../../../../../../generated/l10n.dart';
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
                    PolicyCard(title: s.privacy_policy,
                        onTap: () async{
                          await openTermsAndConditions();
                        }),
                    SizedBox(height: 22.h),
                    PolicyCard(title: s.terms_conditions,
                        onTap: () async{
                          await privacyAndPolicy();
                        }),
                    SizedBox(height: 22.h),
                    // PolicyCard(title: s.refundCancellationPolicy),
                    // SizedBox(height: 22.h),
                    // PolicyCard(title: s.cookiesPolicy),
                    // SizedBox(height: 22.h),
                    // PolicyCard(title: s.userAgreement),
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

Future<void> openTermsAndConditions() async {
  final Uri url = Uri.parse(APIEndpoints.termsAndCondition);

  try {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Forces opening outside the app
    )) {
      print("Could not launch $url");
    }
  } catch (e) {
    print("Error launching URL: $e");
  }
}Future<void> privacyAndPolicy() async {
  final Uri url = Uri.parse(APIEndpoints.privacyAndPolicy);

  try {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Forces opening outside the app
    )) {
      print("Could not launch $url");
    }
  } catch (e) {
    print("Error launching URL: $e");
  }
}
