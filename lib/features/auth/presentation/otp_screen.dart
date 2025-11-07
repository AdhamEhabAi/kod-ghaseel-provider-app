import 'dart:async';

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

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  static const Duration _resendCooldown = Duration(minutes: 2);
  Timer? _timer;
  int _secondsRemaining = _resendCooldown.inSeconds;

  @override
  void initState() {
    super.initState();
    _startCooldown(); // start the initial 2-minute timer on screen open
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void _startCooldown() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = _resendCooldown.inSeconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        t.cancel();
        setState(() {
          _secondsRemaining = 0;
        });
      } else {
        setState(() {
          _secondsRemaining -= 1;
        });
      }
    });
  }

  String _formatMMSS(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

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
            ToastM.show(loc.codeResentSuccessfully);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final isResending =
              state is SendPinLoading || state is ReSendPinLoading;

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
                          context.read<AuthCubit>().loginByPin(
                            phone: widget.phone,
                            pinCode: code,
                          );
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Builder(
                              builder: (_) {
                                if (isResending) {
                                  return const AppLoader();
                                }

                                if (_secondsRemaining > 0) {
                                  return Text(
                                    _formatMMSS(_secondsRemaining),
                                    style: AppTextStyle.blackW400Size14Roboto
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  );
                                }

                                return GestureDetector(
                                  onTap: () {
                                    _startCooldown();
                                    context.read<AuthCubit>().reSendPinCode(
                                      phone: widget.phone,
                                    );
                                  },
                                  child: Text(
                                    loc.resendCode,
                                    style: AppTextStyle.blackW400Size14Roboto
                                        .copyWith(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                );
                              },
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

                                  context.read<AuthCubit>().loginByPin(
                                    phone: widget.phone,
                                    pinCode: code,
                                  );
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
