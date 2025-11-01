import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/profile_repo.dart';

part 'profile_state.dart';

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
}
