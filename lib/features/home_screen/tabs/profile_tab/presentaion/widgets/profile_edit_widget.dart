import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../auth/controller/auth_cubit.dart';
import '../../../../controller/home_screen_cubit.dart';


class ProfileEditWidget extends StatelessWidget {
  const ProfileEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeScreenCubit>();
        String imagePath =
            homeCubit.userData?.profileImage ?? '';

        bool isLocalFile = imagePath.isNotEmpty && File(imagePath).existsSync();
        bool isNetworkImage = imagePath.isNotEmpty && imagePath.startsWith('http');

        return GestureDetector(
          onTap: () {
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
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: AppStyle.primaryColor,
                    borderRadius: BorderRadius.circular(32.r), // make it fully circular
                  ),
                  clipBehavior: Clip.hardEdge, // ensures the image is clipped in circle
                  child: isLocalFile
                      ? Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  )
                      : isNetworkImage
                      ? CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(Icons.person, size: 28.w, color: Colors.black),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(Icons.person, size: 28.w, color: Colors.black),
                      ),
                    ),
                  )
                      : Center(
                    child: Icon(Icons.person, size: 28.w, color: Colors.black),
                  ),
                ),


                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                          (homeCubit.userData?.fullName ?? ''),
                      style: AppTextStyle.blackW600Size20Roboto,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Assets.editIcon),
                        SizedBox(width: 15.w),
                        Text(
                          s.gold_plan,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppStyle.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.edit, color: Colors.black),
              ],
            ),
          ),
        );
      },
    );
  }
}
