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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendPinSuccess) {
          GoRouter.of(context).push(
            AppRouter.otpScreen,
            extra: {'phone': _phoneController.text.trim(), 'isRegister': false},
          );
        } else if (state is SendPinError) {
          ToastM.show(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is SendPinLoading;

        return Form(
          key: _formKey,
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

                /// Phone field
                CustomTextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  hintTextDirection: TextDirection.ltr,
                  hintText: loc.phoneNumberHint,
                  colorBorder: const Color(0xffEEEEEE),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return loc.enterYourPhoneNumber;
                    }
                    if (value.length < 9) {
                      return loc.invalidPhoneNumber;
                    }
                    return null;
                  },
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
                      ? const AppLoader()
                      : DefaultButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final phone = _phoneController.text.trim();
                        context.read<AuthCubit>().sendPinCode(
                          phone: phone,
                        );
                      }
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