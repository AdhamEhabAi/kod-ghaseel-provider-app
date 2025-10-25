import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/toast_m.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendPinSuccess) {
          GoRouter.of(context).push(
            AppRouter.otpScreen,
            extra: {
              'phone': _phoneController.text.trim(),
              'isRegister': false,
            },
          );

        } else if (state is SendPinError) {
          ToastM.show(state.message);
          if (state.message == 'رقم الهاتف غير مسجل') {
            GoRouter.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is SendPinLoading;

        return Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.phoneNumber,
                  style: AppTextStyle.blackW600Size16Roboto,
                ),
                SizedBox(height: 10.h),

                CustomTextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  hintTextDirection: TextDirection.ltr,
                  hintText: loc.phoneNumberHint,
                  colorBorder: const Color(0xffEEEEEE),
                  suffixIcon: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 15.w,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0x8acbcbcb),
                        width: 1.5.w,
                      ),
                      color: const Color(0x66eeeeee),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '+966',
                      style: AppTextStyle.blackW600Size16Roboto,
                    ),
                  ),
                ),

                SizedBox(height: 100.h),

                Center(
                  child: isLoading
                      ? AppLoader()
                      : DefaultButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  final phone = _phoneController.text.trim();
                                  if (phone.isEmpty) {
                                    ToastM.show('loc.enterYourPhoneNumber');

                                    return;
                                  }
                                  context.read<AuthCubit>().sendPinCode(
                                    phone: phone,
                                  );
                                },
                          backgroundColorButton: AppStyle.primaryColor,
                          width: 250.w,
                          borderRadius: BorderRadius.circular(50.r),
                          titleWidget: Text(
                            loc.getVerificationCode,
                            style: AppTextStyle.whiteW600Size16Roboto,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
