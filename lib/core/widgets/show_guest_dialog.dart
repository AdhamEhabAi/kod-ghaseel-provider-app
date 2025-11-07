import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

Future<void> showGuestLoginDialog(BuildContext context) async {
  final loc = S.of(context);

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          loc.registerRequiredTitle,
          style: AppTextStyle.blackW600Size16Roboto,
        ),
        content: Text(
          loc.registerRequiredMessage,
          style: AppTextStyle.blackW400Size14Roboto,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(context).pop(),
            child: Text(
              loc.cancel,
              style: AppTextStyle.blackW600Size14Roboto,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyle.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              GoRouter.of(context).pop();
              BlocProvider.of<AuthCubit>(context).guestUser = null;
              GoRouter.of(context).go(AppRouter.loginScreen);
            },
            child: Text(
              loc.registerNow,
              style: AppTextStyle.whiteW500Size14.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      );
    },
  );
}
