import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

// Apple App Store (since June 2022) and Google Play (since December 2023)
// REQUIRE that apps with user accounts provide an in-app account deletion flow.
// All strings are localised via S.of(context) (AR / EN).
class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  Future<bool> _showConfirmDialog(BuildContext context) async {
    final sd = S.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (ctx) {
            final s = S.of(ctx);
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              title: Text(
                s.deleteAccountConfirmTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
              content: Text(
                s.deleteAccountConfirmMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, height: 1.6),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: Text(
                    s.cancel,
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: Text(
                    s.deleteAccountConfirmButton,
                    style: TextStyle(
                        fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          context.read<ServiceCubit>().stopLocationStream();
          GoRouter.of(context).go(AppRouter.loginScreen);
        } else if (state is DeleteAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is DeleteAccountLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () => GoRouter.of(context).pop(),
            ),
            title: Text(
              s.deleteAccountTitle,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Warning banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.red, size: 28.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          s.deleteAccountWarning,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),

                Text(
                  s.deleteAccountSectionTitle,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
                SizedBox(height: 16.h),

                _buildBullet(s.deleteAccountBullet1),
                _buildBullet(s.deleteAccountBullet2),
                _buildBullet(s.deleteAccountBullet3),
                _buildBullet(s.deleteAccountBullet4),
                _buildBullet(s.deleteAccountBullet5),
                SizedBox(height: 28.h),

                // Data retention notice (GDPR / privacy policy requirement)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    s.deleteAccountRetentionNotice,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.blue.shade800,
                        height: 1.5),
                  ),
                ),
                SizedBox(height: 36.h),

                // Delete button
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      elevation: 0,
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            final confirmed =
                                await _showConfirmDialog(context);
                            if (!confirmed) return;
                            if (context.mounted) {
                              context.read<AuthCubit>().deleteAccount();
                            }
                          },
                    child: isLoading
                        ? SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            s.deleteAccountButton,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Cancel button
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: const BorderSide(color: Color(0xFFDDDDDD)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    onPressed: () => GoRouter.of(context).pop(),
                    child: Text(
                      s.cancel,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 7.w,
              height: 7.h,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.black87, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
