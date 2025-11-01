import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/show_guest_dialog.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/TextFiledTitle.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';

import '../../../../../../Utilites/app_assets/assets.dart';
import '../../../../../../Utilites/app_fonts/font.dart';
import '../../../../../../Utilites/app_style/style.dart';
import '../../../../../../core/widgets/setting_app_bar.dart';
import '../../../../../../shared/shared_widget.dart';
import '../../../../../core/widgets/app_loader.dart';
import '../../../../../core/widgets/toast_m.dart';
import '../controller/profile_cubit.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final authCubit = context.read<AuthCubit>();
    final guestUser = authCubit.guestUser;

    nameController.text = guestUser == null ? 'سارة محمد' : guestUser.fullName;
    emailController.text = 'example@gmail.com';
    phoneController.text = guestUser == null ? '81234567890' : guestUser.phone;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F7),
      body: BlocConsumer(
        listener: (BuildContext context, state) {
          if(state is UpdateProfileSuccess){
            ToastM.show(state.message);
          }else if(state is UpdateProfileError){
            ToastM.show(state.message);
          }
        },
        builder: (context, state) {
          var isLoading=state is UpdateProfileLoading;
          return  SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  SettingAppBar(title: s.profile_title), // "حسابي الشخصي"
                  SizedBox(height: 45.h),
                  SizedBox(
                    height: 110.h,
                    width: 110.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFBEEAF7),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 54)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppStyle.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppStyle.white, width: 4),
                            ),
                            child: SvgPicture.asset(
                              Assets.cameraIconSVG,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFiledTitle(s.profile_username), // "اسم المستخدم"
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            colorBorder: AppStyle.textFieldBorderColor,
                            style: AppTextStyle.blackW600Size16Roboto,
                            color: Colors.transparent,
                            radius: 16.r,
                            prefixIcon: SvgPicture.asset(
                              Assets.personIconSVG,
                              fit: BoxFit.scaleDown,
                            ),
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 12.h),
                          TextFiledTitle(s.profile_email), // "عنوان البريد"
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            textDirection: TextDirection.ltr,
                            colorBorder: AppStyle.textFieldBorderColor,
                            style: AppTextStyle.blackW600Size16Roboto,
                            color: Colors.transparent,
                            radius: 16.r,
                            suffixIcon: const Icon(Icons.email),
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 12.h),
                          TextFiledTitle(s.profile_phone), // "رقم الهاتف"
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            color: Colors.transparent,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            textDirection: TextDirection.ltr,
                            colorBorder: AppStyle.textFieldBorderColor,
                            suffixIcon: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '966+',
                                style: AppTextStyle.blackW400Size16Roboto.copyWith(
                                  fontFamily: "Inter",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 70.h),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child:  isLoading?AppLoader():DefaultButton(
                                backgroundColorButton: AppStyle.primaryColorOpacity10,
                                onPressed: () {
                                  if (context.read<AuthCubit>().guestUser != null) {
                                    showGuestLoginDialog(context);
                                  } else {
                                    context.read<ProfileCubit>().updateProfile();
                                    GoRouter.of(context).pop();
                                  }
                                },
                                borderRadius: BorderRadius.circular(50.r),
                                titleWidget: Text(
                                  s.save, // "حفظ"
                                  style: AppTextStyle.blackW600Size16Roboto
                                      .copyWith(color: const Color(0xFF01D0FE)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
