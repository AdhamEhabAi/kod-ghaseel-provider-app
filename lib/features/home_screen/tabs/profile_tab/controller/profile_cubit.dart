import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/data/models/CheckSessionValidationResponse.dart';

import '../../../../../core/router/router.dart';
import '../../../controller/home_screen_cubit.dart';
import '../data/repo/profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;
  File? imageFile;

  void updateProfile({
    required String fullName ,
    required String dateOfBirth,
    required String gender,
    required String city,
    required String address,
    required String profileImage,
    required String vehicleType,
    required String vehiclePlate,
    required String licenseNumber,
  }) async {
    emit(UpdateProfileLoading());

    final response = await profileRepo.updateProfileData(
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      city: city,
      address: address,
      profileImage: profileImage,
      vehicleType: vehicleType,
      vehiclePlate: vehiclePlate,
      licenseNumber: licenseNumber,
    );
    response.fold(
          (error) {
        emit(UpdateProfileError(message: error.message));
      },
          (success) {
            BlocProvider.of<HomeScreenCubit>(AppRouter.globalNavKey.currentContext!).updateUserData(success.data);
                  emit(UpdateProfileSuccess(message: success.message, user: success.data));
      },
    );
  }

  void requestUpdatePhoneNumber({
    required String phoneNumber ,
  }) async {
    emit(RequestUpdatePhoneNumberLoading());

    // await Future.delayed(Duration(seconds: 5));
    //
    //   bool isSuccess = true;
    //
    //   if (isSuccess) {
    //     emit(RequestUpdatePhoneNumberSuccess(message: "message"));
    //   } else {
    //      emit(RequestUpdatePhoneNumberError(message: "error"));
    //   }

    var response = await profileRepo.updatePhoneNumberRequest(
      phoneNumber: phoneNumber,
    );
    response.fold(
          (error) {
        emit(RequestUpdatePhoneNumberError(message: error.message));
      },
          (success) {
        emit(RequestUpdatePhoneNumberSuccess(message: success.message ?? ""));
      },
    );
  }

  void verifyPhoneWithOtp({
    required String otp ,
  }) async {
    emit(VerifyChangePhoneNumberLoading());
    // await Future.delayed(Duration(seconds: 5));
    // if(otp=="1234"){
    //   emit(VerifyChangePhoneNumberSuccess(message: "success"));
    // }else{
    //   emit(VerifyChangePhoneNumberError(message: "error"));
    // }
    var response = await profileRepo.verifyPhoneWithOtp(
      otp: otp,
    );
    response.fold(
          (error) {
        emit(VerifyChangePhoneNumberError(message: error.message));
      },
          (success) {
        emit(VerifyChangePhoneNumberSuccess(message: success.message ?? ""));
      },
    );

  }
  Future<void> pickAndSet({required bool fromCamera}) async {
    final file = await pickImage(fromCamera: fromCamera);
    if (file == null) return;
    imageFile = file;
    emit(PickAndSetImageSuccessState());

  }
  Future<File?> pickImage({required bool fromCamera}) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 80,
    );
    return pickedFile == null ? null : File(pickedFile.path);
  }
}
