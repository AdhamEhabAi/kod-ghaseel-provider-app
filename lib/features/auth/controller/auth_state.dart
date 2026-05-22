part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

class SendPinLoading extends AuthState {}

class SendPinSuccess extends AuthState {}

class SendPinError extends AuthState {
  final String message;
  SendPinError({required this.message});
}


class RegisterLoading extends AuthState {}
class RegisterSuccess extends AuthState {}
class RegisterError extends AuthState {
  final String message;
  RegisterError({required this.message});
}
class ReSendPinLoading extends AuthState {}
class ReSendPinSuccess extends AuthState {}
class ReSendPinError extends AuthState {
  final String message;
  ReSendPinError({required this.message});
}
class LogoutLoading extends AuthState {}
class LogoutSuccess extends AuthState {}
class LogoutError extends AuthState {
  final String message;
  LogoutError({required this.message});
}
class FcmTokenUpdated extends AuthState {}

class DeleteAccountLoading extends AuthState {}

class DeleteAccountSuccess extends AuthState {}

class DeleteAccountError extends AuthState {
  final String message;
  DeleteAccountError({required this.message});
}
