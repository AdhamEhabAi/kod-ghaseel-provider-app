import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/first_section_profile_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/profile_edit_widget.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/profile_tab_appbar.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/second_section_profile_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/third_section_profile_tab.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_fonts/font.dart';


class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F5),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 20.h),
                child: const ProfileTabAppBar(),
              ),
              SizedBox(height: 24.h),
              Text(
                s.profile_title, // "حسابي الشخصي"
                style: AppTextStyle.blackW700Size14Roboto.copyWith(
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: 24.h),

              const ProfileEditWidget(),
              SizedBox(height: 20.h),

              const FirstSectionProfileTab(),

              SizedBox(height: 16.h),

              const SecondSectionProfileTab(),

              SizedBox(height: 16.h),

              const ThirdSectionProfileTab(),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
