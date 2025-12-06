import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/phone_section.dart';

import '../../controller/profile_cubit.dart';
import 'otp_section.dart';

class ChangePhoneSheet extends StatefulWidget {
  const ChangePhoneSheet({super.key, required this.phone});

  final String phone;

  @override
  State<ChangePhoneSheet> createState() => _ChangePhoneSheetState();
}

class _ChangePhoneSheetState extends State<ChangePhoneSheet> {

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: viewInsets),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is VerifyChangePhoneNumberSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  if (state is RequestUpdatePhoneNumberSuccess ||
                      state is VerifyChangePhoneNumberError ||
                      state is VerifyChangePhoneNumberLoading) {
                    return OtpSection(
                      phone: widget.phone,
                    );
                  } else {
                    return PhoneSection(
                      phone: widget.phone,
                      key: const ValueKey('phone'),
                      // formKey: _phoneFormKey,
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
