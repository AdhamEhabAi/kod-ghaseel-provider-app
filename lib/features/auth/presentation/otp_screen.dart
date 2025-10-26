import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/auth/presentation/widgets/otp_text_field_widget.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';


class OtpScreen extends StatefulWidget {
  final String phone;
  final bool isRegister;

  const OtpScreen({
    super.key,
    required this.phone,
    this.isRegister = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            GoRouter.of(context).go(AppRouter.homeScreen);
          } else if (state is AuthError) {
            ToastM.show(state.message);
          } else if (state is SendPinSuccess) {
            ToastM.show('loc.codeResentSuccessfully');
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isResending = state is SendPinLoading;

          return SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                    () => GoRouter.of(context).pop(),
                              );
                            },
                            child: SvgPicture.asset(Assets.chevronBackward),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            loc.enterCode,
                            style: AppTextStyle.blackW600Size28Roboto,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 24.w),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 220.h),
                Padding(
                  padding: EdgeInsets.all(30.w),
                  child: Column(
                    children: [
                      OTPTextField(
                        controller: otpController,
                        onCompleted: (code) {
                          if (widget.isRegister) {
                            context.read<AuthCubit>().verifyPinCodeForRegister(
                              pinCode: code,
                            );
                          } else {
                            context.read<AuthCubit>().loginByPin(
                              phone: widget.phone,
                              pinCode: code,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 10.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            loc.didNotReceiveCode,
                            style: AppTextStyle.blackW400Size14Roboto.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: isResending
                                ? null
                                : () => context.read<AuthCubit>().sendPinCode(
                              phone: widget.phone,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: isResending
                                  ? const AppLoader()
                                  : Text(
                                loc.resendCode,
                                style: AppTextStyle.blackW400Size14Roboto
                                    .copyWith(
                                  color: Colors.black,
                                  decoration:
                                  TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),

                      Center(
                        child: isLoading
                            ? const AppLoader()
                            : DefaultButton(
                          width: 250.w,
                          onPressed: () {
                            final code = otpController.text.trim();
                            if (code.isEmpty) {
                              ToastM.show(loc.fieldRequired);
                              return;
                            }

                            if (widget.isRegister) {
                              context
                                  .read<AuthCubit>()
                                  .verifyPinCodeForRegister(
                                pinCode: code,
                              );
                            } else {
                              context.read<AuthCubit>().loginByPin(
                                phone: widget.phone,
                                pinCode: code,
                              );
                            }
                          },
                          backgroundColorButton: AppStyle.primaryColor,
                          borderRadius: BorderRadius.circular(50.r),
                          titleWidget: Text(
                            loc.login,
                            style: AppTextStyle.whiteW600Size16Roboto,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
