import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/widgets/option_tile.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/widgets/profile_edit_widget.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/widgets/profile_tab_appbar.dart';
import '../../../../Utilites/app_assets/assets.dart';
import '../../../../Utilites/app_fonts/font.dart';
import '../../../../Utilites/app_style/style.dart';
import '../../../../core/router/router.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF2F4F5),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileTabAppBar(),
              SizedBox(height: 24.h),
              Text(
                'حسابي الشخصي',
                style: AppTextStyle.blackW700Size14Roboto.copyWith(
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: 24.h),

              ProfileEditWidget(),
              SizedBox(height: 20.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1200.00",
                        style: AppTextStyle.blackW700Size14Roboto.copyWith(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                        Assets.riyal,
                        width: 20.w,
                        color: Colors.grey,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 20.w,
                        color: AppStyle.primaryColor,
                      ),
                      SizedBox(width: 8.w),

                      Text(
                        "رصيدك الحالي",
                        style: AppTextStyle.blackW500Size18Roboto,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              OptionTile(title: "الاعدادات", icon: Icons.settings,onTap: (){
                GoRouter.of(context).push(AppRouter.settingScreen);
              },),
              SizedBox(height: 12.h),
              OptionTile(title: "المساعدة والدعم", icon: Icons.info,onTap: () {
                GoRouter.of(context).push(AppRouter.helpCenterScreen);
              },),
              SizedBox(height: 12.h),
              OptionTile(title: "التواصل", icon: Icons.phone,onTap:() {

              },),
            ],
          ),
        ),
      ),
    );
  }
}
