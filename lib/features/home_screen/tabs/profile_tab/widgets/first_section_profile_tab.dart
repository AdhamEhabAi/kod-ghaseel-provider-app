import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/widgets/option_tile.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import '../../../../../../core/router/router.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- localization

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
            title: context.read<AuthCubit>().guestUser == null
                ? s.userPhoneNumber
                : context.read<AuthCubit>().guestUser?.phone ?? '',
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
