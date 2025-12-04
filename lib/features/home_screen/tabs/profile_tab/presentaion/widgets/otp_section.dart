import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/widgets/app_loader.dart';
import '../../../../../../core/widgets/toast_m.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../auth/presentation/widgets/otp_text_field_widget.dart';
import '../../controller/profile_cubit.dart';

class OtpSection extends StatefulWidget {
  final String phone;
  const OtpSection({super.key, required this.phone});

  @override
  State<OtpSection> createState() => _OtpSectionState();
}

class _OtpSectionState extends State<OtpSection> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is VerifyChangePhoneNumberError) {
          ToastM.show(state.message);
        }
        if (state is VerifyChangePhoneNumberSuccess) {
          ToastM.show(s.phoneNumberChangedSuccessfully);
        }
      },
      builder: (context, state) {
        final loading = state is VerifyChangePhoneNumberLoading;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    s.enterVerificationCodeSentTo(widget.phone),
                    style: AppTextStyle.blackW600Size18Roboto,
                  ),
                ),
                TextButton(
                  onPressed: loading ? null : () {
                    FocusScope.of(context).unfocus();
                    GoRouter.of(context).pop();
                  },
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            OTPTextField(controller: controller), // must bind internally
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyle.primaryColorOpacity10,
                  elevation: 0,
                ),
                onPressed: loading ? null : () {
                  final otp = controller.text;
                  print(otp);
                  context.read<ProfileCubit>().verifyPhoneWithOtp(otp: otp);
                },
                child: loading
                    ? const SizedBox(height: 18, width: 18, child: AppLoader())
                    : Text(s.verify, style: AppTextStyle.primaryW600Size16),
              ),
            ),
          ],
        );
      },
    );
  }
}
