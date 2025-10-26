import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../shared/shared_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart'; // <-- l10n

void showExitDialog(BuildContext context) {
  final s = S.of(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        title: Center(
          child: Text(s.logoutTitle, style: AppTextStyle.blackW600Size24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
              backgroundColorButton: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              onPressed: () {
                if (context.read<AuthCubit>().guestUser != null) {
                  BlocProvider.of<AuthCubit>(context).guestUser = null;
                  GoRouter.of(context).go(AppRouter.registerScreen);
                } else {

                  GoRouter.of(context).go(AppRouter.registerScreen);
                }
              },
              titleWidget: Text(
                s.logoutConfirm, // "نعم, بالتأكيد!"
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  color: AppStyle.red,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            DefaultButton(
              backgroundColorButton: AppStyle.primaryColor,
              borderRadius: BorderRadius.circular(20.r),
              onPressed: () {
                GoRouter.of(context).pop();
              },
              titleWidget: Text(
                s.no, // "لا"
                style: AppTextStyle.blackW600Size16Roboto.copyWith(
                  color: AppStyle.white,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
