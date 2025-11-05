part of 'profile_cubit.dart';


@immutable
abstract class ProfileState{}

class ProfileInitial extends ProfileState{}
class UpdateProfileLoading extends ProfileState{}
class UpdateProfileSuccess extends ProfileState{
  final String message;
  UpdateProfileSuccess({required this.message});
}
class UpdateProfileError extends ProfileState{
  final String message;
  UpdateProfileError({required this.message});

}
class RequestUpdatePhoneNumberLoading extends ProfileState{}
class RequestUpdatePhoneNumberSuccess extends ProfileState{
  final String message;
  RequestUpdatePhoneNumberSuccess({required this.message});
}
class RequestUpdatePhoneNumberError extends ProfileState{
  final String message;
  RequestUpdatePhoneNumberError({required this.message});

}
class VerifyChangePhoneNumberLoading extends ProfileState{}
class VerifyChangePhoneNumberSuccess extends ProfileState{
  final String message;
  VerifyChangePhoneNumberSuccess({required this.message});
}
class VerifyChangePhoneNumberError extends ProfileState {
  final String message;

  VerifyChangePhoneNumberError({required this.message});
}