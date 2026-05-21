import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/show_help_dialog.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../core/router/router.dart';
import 'option_tile.dart';

class ThirdSectionProfileTab extends StatelessWidget {
  const ThirdSectionProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      children: [
        // Rate, share, about, support
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              // OptionTile(
              //   title: s.rateApp,
              //   iconPath: Assets.starProfileTab,
              //   onTap: () {},
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.w),
              //   child: Divider(
              //       height: 24.h,
              //       thickness: 1,
              //       color: const Color(0xFFF2F4F5)),
              // ),
              // OptionTile(
              //   title: s.shareWithFriends,
              //   iconPath: Assets.shareProfileTab,
              //   onTap: () {},
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.w),
              //   child: Divider(
              //       height: 24.h,
              //       thickness: 1,
              //       color: const Color(0xFFF2F4F5)),
              // ),
              // OptionTile(
              //   title: s.aboutUs,
              //   iconPath: Assets.infoSquareProfileTab,
              //   onTap: () {},
              // ),
              // OptionTile(
              //   title: s.aboutUs,
              //   iconPath: Assets.infoSquareProfileTab,
              //   onTap: () {},
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.w),
              //   child: Divider(
              //       height: 24.h,
              //       thickness: 1,
              //       color: const Color(0xFFF2F4F5)),
              // ),
              OptionTile(
                title: s.support,
                iconPath: Assets.infoSquareProfileTab,
                onTap: () => showSupportContactDialog(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Delete account — separate card, red styling, required by App Store / Play Store
        // Apple requires this since June 2022; Google Play since December 2023.
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () => GoRouter.of(context).push(AppRouter.deleteAccountScreen),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.delete_forever_rounded,
                          color: Colors.red, size: 24.sp),
                      SizedBox(width: 14.w),
                      Text(
                        s.deleteAccountTitle,
                        style: AppTextStyle.blackW600Size16Roboto.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    isArabic
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                    size: 18.w,
                    color: Colors.red.shade300,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
