import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../../Utilites/app_style/style.dart';
import '../../../../../../../core/router/router.dart';
import '../../../../../../../shared/shared_widget.dart';

void showExitDialog(BuildContext context) {
  final s = S.of(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            GoRouter.of(context).go(AppRouter.loginScreen);
          } else if (state is LogoutError) {
            ToastM.show(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is LogoutLoading;

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
                Column(
                  children: [
                    !isLoading
                        ? DefaultButton(
                            backgroundColorButton: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            onPressed: () {
                              final authCubit = context.read<AuthCubit>();

                              if (authCubit.guestUser != null) {
                                authCubit.guestUser = null;
                                GoRouter.of(
                                  context,
                                ).go(AppRouter.loginScreen);
                              } else {
                                authCubit.logout();
                              }
                            },
                            titleWidget: Text(
                              s.logoutConfirm,
                              style: AppTextStyle.blackW600Size16Roboto
                                  .copyWith(color: AppStyle.red),
                            ),
                          )
                        : Center(child: AppLoader()),
                    SizedBox(height: 10.h),
                    DefaultButton(
                      backgroundColorButton: AppStyle.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      titleWidget: Text(
                        s.no,
                        style: AppTextStyle.blackW600Size16Roboto.copyWith(
                          color: AppStyle.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
