import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../data/repo/profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  void updateProfile({
    String fullName = "",
    String dateOfBirth = "",
    String gender = "",
    String city = "",
    String address = "",
    String profileImage = "",
  }) async {
    emit(UpdateProfileLoading());
    var response = await profileRepo.updateProfileData(
      fullName: fullName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      city: city,
      address: address,
      profileImage: profileImage,
    );
    response.fold(
          (error) {
        emit(UpdateProfileError(message: error.message));
      },
          (success) {
        emit(UpdateProfileSuccess(message: success.message ?? ""));
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
}
