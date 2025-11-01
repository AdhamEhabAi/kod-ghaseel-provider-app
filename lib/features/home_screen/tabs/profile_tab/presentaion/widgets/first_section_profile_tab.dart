import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import '../../../../../../core/router/router.dart';
import 'option_tile.dart';


class FirstSectionProfileTab extends StatelessWidget {
  const FirstSectionProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          OptionTile(
            title: s.add_personal_email, // "اضف ايميل شخصي"
            iconPath: Assets.emailProfileTab,
            onTap: () {
              GoRouter.of(context).push(AppRouter.editProfileScreen);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Divider(
              height: 24.h,
              thickness: 1,
              color: const Color(0xFFF2F4F5),
            ),
          ),
          OptionTile(
            title: "+966 1515 1511 333",
            iconPath: Assets.callProfileTab,
            onTap: () {
              GoRouter.of(context).push(AppRouter.editProfileScreen);
            },
          ),
        ],
      ),
    );
  }
}
