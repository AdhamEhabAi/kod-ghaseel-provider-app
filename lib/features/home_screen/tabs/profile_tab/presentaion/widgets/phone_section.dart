import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/widgets/app_loader.dart';
import '../../../../../../core/widgets/toast_m.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../shared/shared_widget.dart';
import '../../controller/profile_cubit.dart';

class PhoneSection extends StatefulWidget {
  final String phone;

  const PhoneSection({super.key, required this.phone});

  @override
  State<PhoneSection> createState() => _PhoneSectionState();
}

class _PhoneSectionState extends State<PhoneSection> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.phone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context);
    final loading =
        context.watch<ProfileCubit>().state is RequestUpdatePhoneNumberLoading;

    return BlocListener<ProfileCubit,ProfileState>(
      listener: (context, state) {
        if(state is RequestUpdatePhoneNumberError){
          ToastM.show(state.message);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'ادخل رقم الهاتف الجديد',
                  style: AppTextStyle.blackW600Size18Roboto,
                ),
              ),
              TextButton(
                onPressed: loading ? null : () => GoRouter.of(context).pop(),
                child: const Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Form(
            key: _formKey,
            child: CustomTextFormField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
              hintTextDirection: TextDirection.ltr,
              hintText: loc.phoneNumberHint,
              colorBorder: const Color(0xffEEEEEE),
              validator: (value) {
                if (value == null || value.trim().isEmpty)
                  return loc.enterYourPhoneNumber;
                if (value.length < 9) return loc.invalidPhoneNumber;
                return null;
              },
              suffixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0x8acbcbcb),
                    width: 1.5.w,
                  ),
                  color: const Color(0x66eeeeee),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text('+966', style: AppTextStyle.blackW600Size16Roboto),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyle.primaryColorOpacity10,
                elevation: 0,
              ),
              onPressed: loading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileCubit>().requestUpdatePhoneNumber(
                          phoneNumber: _controller.text,
                        );
                      }
                    },
              child: loading
                  ? const SizedBox(height: 18, width: 18, child: AppLoader())
                  : Text('التالي', style: AppTextStyle.primaryW600Size16),
            ),
          ),
        ],
      ),
    );
  }
}
