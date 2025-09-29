import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/setting/widgets/setting_item_row.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/widgets/setting_app_bar.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingAppBar(title: "الاعدادات",),
            SizedBox(height: 40.h,),
            SettingItemsRow(
              onTap: (){},
              title: "تغيير رقم الهاتف",
              icon: Icons.phone,
            ),
            SizedBox(height: 30.h,),
            SettingItemsRow(
              onTap: (){
                GoRouter.of(context).push(AppRouter.notificationSettingScreen);
              },
              icon: Icons.notifications,
              title: "الاشعارات",
            ),
            SizedBox(height: 23.h,),
            Divider(
              color: Color(0x0d131313),
              endIndent: 12.w,
              indent: 12.w,
            ),
            SizedBox(height: 23.h,),
            SettingItemsRow(
              onTap: (){
                GoRouter.of(context).push(AppRouter.privacyScreen);
              },
              title: "سياسات الخصوصية",
              icon: Icons.lock,
            ),
          ],
        ),
      ),


    );
  }
}


