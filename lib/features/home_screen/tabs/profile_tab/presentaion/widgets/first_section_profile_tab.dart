import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import '../../../../../../core/helpers/shared_prefrence.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../auth/data/models/login_response.dart';
import 'change_phone_sheet.dart';
import 'option_tile.dart';


class FirstSectionProfileTab extends StatelessWidget {
  const FirstSectionProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var s =S.of(context);

    final String? userJson =
    AppSharedPreferences.getString(SharedPreferencesKeys.userModel);

    final String? phone = userJson != null
        ? User.fromJson(jsonDecode(userJson)).phone.toString() : null;
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          OptionTile(title: s.add_personal_email, iconPath: Assets.emailProfileTab, onTap: (){
            context.push(AppRouter.editProfileScreen);
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Divider(height: 24.h, thickness: 1, color: const Color(0xFFF2F4F5)),
          ),
          OptionTile(
            title: phone??"000000",
            iconPath: Assets.callProfileTab,
            onTap: () {
              showModalBottomSheet(
                isDismissible: false,
                isScrollControlled: true,
                context: context,
                builder: (context) =>
                    PopScope(canPop: false, child: ChangePhoneSheet(phone:phone??"00000")),
              );
            },
          ),
        ],
      ),
    );
  }
}
