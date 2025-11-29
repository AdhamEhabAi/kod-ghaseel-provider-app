import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/core/firebase_notification/notification_service.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/auth_repo/auth_repo.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/models/login_response.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/models/request_pin_response.dart';

import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial()) {
    _initializeDeviceInfo();
  }

  LoginResponse? loginResponse;
  RequestPinResponse? requestPinResponse;
  String? deviceId;
  String? deviceType;

  Future<void> _initializeDeviceInfo() async {
    deviceId = AppSharedPreferences.getString(SharedPreferencesKeys.uuid);
    deviceType = AppSharedPreferences.getString(
      SharedPreferencesKeys.deviceType,
    );

    if (deviceId == null ||
        deviceId!.isEmpty ||
        deviceType == null ||
        deviceType!.isEmpty) {
      await getDeviceInfo();
    }
  }

  Future<void> sendPinCode({required String phone}) async {
    emit(SendPinLoading());

    await _ensureDeviceInfo();

    final result = await authRepo.sendPinCode(
      mobile: phone,
      deviceId: deviceId ?? '',
      deviceType: deviceType ?? '',
    );

    result.fold(
      (Failure failure) => emit(SendPinError(message: failure.message)),
      (RequestPinResponse response) {
        requestPinResponse = response;
        emit(SendPinSuccess());
      },
    );
  }

  Future<void> loginByPin({
    required String phone,
    required String pinCode,
  }) async {
    emit(AuthLoading());

    await _ensureDeviceInfo();

    final result = await authRepo.loginByMobile(
      mobile: phone,
      pinCode: pinCode,
      deviceId: deviceId ?? '',
      deviceType: deviceType ?? '',
    );

    result.fold(
      (Failure failure) => emit(AuthError(message: failure.message)),
      (LoginResponse response) async {
        loginResponse = response;

        await AppSharedPreferences.setString(
          SharedPreferencesKeys.accessToken,
          loginResponse?.data?.sessionToken ?? '',
        );
        try {
          final userJson = loginResponse?.data?.user.toJson();
          if (userJson != null) {
            await AppSharedPreferences.setString(
              SharedPreferencesKeys.userModel,
              jsonEncode(userJson),
            );
          }
        } catch (e) {
          emit(AuthError(message: 'Failed to save user model: $e'));
          return;
        }

        emit(AuthSuccess());
      },
    );
  }
  Future<void> reSendPinCode({required String phone}) async {
    emit(ReSendPinLoading());

    await _ensureDeviceInfo();

    final result = await authRepo.reSendPinCode(mobile: phone);

    result.fold(
      (Failure failure) => emit(ReSendPinError(message: failure.message)),
      (RequestPinResponse response) {
        requestPinResponse = response;
        emit(ReSendPinSuccess());
      },
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());

    final result = await authRepo.logout();

    result.fold(
      (Failure failure) => emit(LogoutError(message: failure.message)),
      (String response) {
        AppSharedPreferences.clear();
        emit(LogoutSuccess());
      },
    );
  }

  Future<void> getDeviceInfo() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceType = 'android';
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceType = 'ios';
        deviceId = iosInfo.identifierForVendor ?? '';
      }

      await AppSharedPreferences.setString(
        SharedPreferencesKeys.uuid,
        deviceId ?? '',
      );
      await AppSharedPreferences.setString(
        SharedPreferencesKeys.deviceType,
        deviceType ?? '',
      );
    } catch (e) {
      emit(AuthError(message: 'Failed to get device info: $e'));
    }
  }
  Future<String?> getFcmToken() async {
    return await NotificationService.instance.getTokenFireBase();
  }
  Future<void> _ensureDeviceInfo() async {
    if (deviceId == null ||
        deviceId!.isEmpty ||
        deviceType == null ||
        deviceType!.isEmpty) {
      await getDeviceInfo();
    }
  }
}
