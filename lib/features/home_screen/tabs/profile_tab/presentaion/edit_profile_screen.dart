import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_assets/assets.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_fonts/font.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/app_loader.dart';
import 'package:kod_ghaseel_provider_app/core/widgets/setting_app_bar.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/TextFiledTitle.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/presentaion/widgets/choose_image_sheet.dart';
import 'package:kod_ghaseel_provider_app/generated/l10n.dart';
import 'package:kod_ghaseel_provider_app/shared/shared_widget.dart';

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

  String? image;

  @override
  void initState() {
    super.initState();

    final homeCubit = context.read<HomeScreenCubit>();
    final userModel = homeCubit.userData;

    image = userModel?.profileImage;

    nameController.text = userModel?.fullName ?? '';
    emailController.text =
         userModel?.email ??
            'example@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F7),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) async {
          if (state is UpdateProfileSuccess) {
            ToastM.show(state.message);
            image = state.user.profileImage;
            GoRouter.of(context).pop(true);
          } else if (state is UpdateProfileError) {
            ToastM.show(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is UpdateProfileLoading;

          Widget buildPersonPlaceholder() {
            return Center(
              child: Text('🧑🏻‍🦱', style: TextStyle(fontSize: 50.sp)),
            );
          }

          Widget buildAvatarImage() {
            if (profileCubit.imageFile != null) {
              return Image.file(
                profileCubit.imageFile!,
                fit: BoxFit.cover,
                width: 120.r,
                height: 120.r,
              );
            }

            if (image != null && image!.isNotEmpty && image != "no image") {
              if (image!.startsWith('http')) {
                return CachedNetworkImage(
                  imageUrl: image!,
                  fit: BoxFit.cover,
                  width: 120.r,
                  height: 120.r,
                  placeholder: (context, url) => AppLoader(),
                  errorWidget: (context, url, error) => AppLoader(),
                );
              }
            }

            return buildPersonPlaceholder();
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  SettingAppBar(title: s.profile_title),
                  SizedBox(height: 45.h),

                  /// Avatar
                  SizedBox(
                    height: 120.r,
                    width: 120.r,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 120.r,
                          height: 120.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFFBEEAF7),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(child: buildAvatarImage()),
                        ),
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => ChooseImageSourceSheet(),
                                isScrollControlled: true,
                              );
                            },
                            customBorder: const CircleBorder(),
                            child: Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(4.r),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF01D0FE),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: SvgPicture.asset(Assets.cameraIconSVG),
                              ),
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
                          TextFiledTitle(s.profile_username),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            colorBorder: AppStyle.textFieldBorderColor,
                            style: AppTextStyle.blackW600Size16Roboto,
                            controller: nameController,
                            prefixIcon: SvgPicture.asset(
                              Assets.personIconSVG,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          TextFiledTitle(s.profile_email),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            textDirection: TextDirection.ltr,
                            colorBorder: AppStyle.textFieldBorderColor,
                            style: AppTextStyle.blackW600Size16Roboto,
                            controller: emailController,
                            suffixIcon: const Icon(Icons.email),
                          ),

                          SizedBox(height: 94.h),

                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: isLoading
                                  ? const AppLoader()
                                  : DefaultButton(
                                      backgroundColorButton:
                                          AppStyle.primaryColorOpacity10,
                                      onPressed: () async {
                                        // Convert image to base64
                                        final file = profileCubit.imageFile
                                            ?.readAsBytesSync();
                                        final base64Image = base64Encode(
                                          file ?? [],
                                        );
                                        profileCubit.updateProfile(
                                          fullName: nameController.text,
                                          gender: "male",
                                          dateOfBirth: "1990-01-01",
                                          profileImage: base64Image,
                                          city: 'ِAlex',
                                          address: '25asd',
                                          vehicleType: 'Toktok',
                                          vehiclePlate: '1235',
                                          licenseNumber: 'شسم',
                                          email:emailController.text
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(50.r),
                                      titleWidget: Text(
                                        s.save,
                                        style: AppTextStyle
                                            .blackW600Size16Roboto
                                            .copyWith(
                                              color: const Color(0xFF01D0FE),
                                            ),
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

Future<String> imageToBase64(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  return base64Encode(bytes);
}
