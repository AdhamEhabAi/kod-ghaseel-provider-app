import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/setting/widgets/setting_item_row.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../core/router/router.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';



class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingAppBar(title: s.settingsTitle),

            Padding(
              padding: AppStyle.paddingContainerHome,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: .5, color: AppStyle.grey),
                ),
                child: Column(
                  children: [
                    SettingItemsRow(
                      onTap: () {
                        context.read<HomeScreenCubit>().changeLanguage(context);
                      },
                      title: s.change_language,
                      icon: Icons.language,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Divider(color: AppStyle.grey, height: 23.h),
                    ),
                    SettingItemsRow(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.privacyScreen);
                      },
                      icon: Icons.notifications,
                      title: s.security_and_privacy,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Divider(color: AppStyle.grey, height: 23.h),
                    ),

                    SettingItemsRow(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.helpCenterScreen);
                      },
                      title: s.help,
                      icon: Icons.lock,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


