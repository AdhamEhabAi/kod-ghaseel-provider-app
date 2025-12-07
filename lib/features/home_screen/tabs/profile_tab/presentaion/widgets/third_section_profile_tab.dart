import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/show_help_dialog.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import 'option_tile.dart';



class ThirdSectionProfileTab extends StatelessWidget {
  const ThirdSectionProfileTab({super.key});

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
          // OptionTile(
          //   title: s.rateApp, // "تقييم التطبيق"
          //   iconPath: Assets.starProfileTab,
          //   onTap: () {},
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.w),
          //   child: Divider(height: 24.h, thickness: 1, color: const Color(0xFFF2F4F5)),
          // ),
          // OptionTile(
          //   title: s.shareWithFriends, // "شارك مع اصدقائك"
          //   iconPath: Assets.shareProfileTab,
          //   onTap: () {},
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.w),
          //   child: Divider(height: 24.h, thickness: 1, color: const Color(0xFFF2F4F5)),
          // ),
          // OptionTile(
          //   title: s.aboutUs, // "من نحن؟"
          //   iconPath: Assets.infoSquareProfileTab,
          //   onTap: () {},
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 8.w),
          //   child: Divider(height: 24.h, thickness: 1, color: const Color(0xFFF2F4F5)),
          // ),
          OptionTile(
            title: s.support, // "الدعم"
            iconPath: Assets.infoSquareProfileTab,
            onTap: () {
              showSupportContactDialog(context);
            },
          ),
        ],
      ),
    );
  }
}
