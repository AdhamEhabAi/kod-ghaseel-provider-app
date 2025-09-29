import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Utilites/app_assets/assets.dart';
import '../../../../../Utilites/app_fonts/font.dart';
import '../../../../../Utilites/app_style/style.dart';
import '../../../../../core/router/router.dart';


class ProfileEditWidget extends StatelessWidget {
  const ProfileEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).push(AppRouter.editProfileScreen);
      },

      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppStyle.primaryColor,
                borderRadius: BorderRadius.circular(21.r),
              ),
              child: Icon(Icons.person, size: 40.w, color: Colors.black),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("سارة محمد", style: AppTextStyle.blackW600Size20Roboto),
                Row(
                  children: [
                    SvgPicture.asset(Assets.editIcon),
                    SizedBox(width: 15.w),
                    Text(
                      "باقة ذهبية",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Icon(Icons.edit, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
