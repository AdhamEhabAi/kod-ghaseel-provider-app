import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/data/models/banner_response_model.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';

import '../../../core/widgets/toast_m.dart';
import '../../../generated/l10n.dart';
import '../data/home_repo/home_repo.dart';
import '../data/models/CheckSessionValidationResponse.dart';
import '../data/models/provider_status_response.dart';

part 'home_screen_state.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenState> {
  Locale _currentLocale = const Locale('ar');
  final HomeRepo homeRepo;
  final ServiceCubit serviceCubit;
  UserData? userData;

  HomeScreenCubit(this.homeRepo, this.serviceCubit)
    : super(HomeScreenInitial()) {
    loadLanguage();
  }

  Locale get currentLocale => _currentLocale;
  List<BannerItem> sliderBanners = [];

  // Provider status
  ProviderStatusData? _providerStatus;
  ProviderStatusData? get providerStatus => _providerStatus;
  bool get isProviderOnline => _providerStatus?.isOnline ?? false;
  Future<void> loadLanguage() async {
    String? savedLang = AppSharedPreferences.getString(
      SharedPreferencesKeys.language,
    );
    _currentLocale = Locale(savedLang ?? 'ar');
    emit(HomeScreenLanguageLoaded(_currentLocale));
  }

  Future<void> changeLanguage(BuildContext context) async {
    final currentLang = _currentLocale.languageCode;
    final newLangCode = currentLang == 'ar' ? 'en' : 'ar';
    final newLocale = Locale(newLangCode);

    await AppSharedPreferences.setString(
      SharedPreferencesKeys.language,
      newLangCode,
    );

    _currentLocale = newLocale;
    emit(HomeScreenLanguageChanged(newLocale));
  }

  Future<void> checkSessionValidation() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      final message = S.current.no_internet;
      ToastM.show(message);
      emit(NotValidateSession(message: message));
      return;
    }
    emit(ValidationLoadingState());
    final result = await homeRepo.checkSessionValidation();

    result.fold(
      (failure) => emit(NotValidateSession(message: failure.message)),
      (response) async {
        final userJson = response.data?.toJson();
        if (userJson != null) {
          await AppSharedPreferences.setString(
            SharedPreferencesKeys.userModel,
            jsonEncode(userJson),
          );
        }

        userData = response.data;
        loadUser();

        emit(ValidatedSession(response: response));
      },
    );
  }

  void loadUser() {
    final userString =
        AppSharedPreferences.getString(SharedPreferencesKeys.userModel) ?? "";
    userData = UserData.fromJson(jsonDecode(userString));
    emit(UserDataLoaded(userDara: userData));
  }

  void updateUserData(UserData newData) {
    AppSharedPreferences.setString(
      SharedPreferencesKeys.userModel,
      jsonEncode(newData),
    );
    userData = newData;
    emit(UserDataLoaded(userDara: newData));
  }

  Future<void> getHomeBanners() async {
    emit(HomeBannersLoading());

    final result = await homeRepo.getHomeBanners();

    result.fold((failure) => emit(HomeBannersError(message: failure.message)), (
      response,
    ) {
      sliderBanners = response.data
          .where((banner) => banner.displayType.toLowerCase() == 'slider')
          .toList();

      emit(HomeBannersLoaded());
    });
  }

  Future<void> getProviderStatus() async {
    emit(ProviderStatusLoading());
    final result = await homeRepo.getProviderStatus();
    result.fold(
      (failure) => emit(ProviderStatusError(message: failure.message)),
      (response) {
        _providerStatus = response.data;
        emit(ProviderStatusLoaded(response: response));
        // Control location stream based on provider status
        _handleLocationStreamBasedOnStatus();
      },
    );
  }

  Future<void> setProviderOnline() async {
    emit(ProviderStatusLoading());
    final result = await homeRepo.setProviderOnline();
    result.fold(
      (failure) => emit(ProviderStatusError(message: failure.message)),
      (response) {
        _providerStatus = response.data;
        emit(ProviderStatusLoaded(response: response));
        // Control location stream based on provider status
        _handleLocationStreamBasedOnStatus();
      },
    );
  }

  Future<void> setProviderOffline({required int hours}) async {
    emit(ProviderStatusLoading());
    final result = await homeRepo.setProviderOffline(hours: hours);
    result.fold(
      (failure) => emit(ProviderStatusError(message: failure.message)),
      (response) {
        _providerStatus = response.data;
        emit(ProviderStatusLoaded(response: response));
        // Control location stream based on provider status
        _handleLocationStreamBasedOnStatus();
      },
    );
  }

  /// Handle location stream based on provider online/offline status
  void _handleLocationStreamBasedOnStatus() {
    final isOnline = isProviderOnline;
    final serviceState = serviceCubit.state;

    debugPrint(
      '📍 [HomeScreenCubit] Provider status changed - Online: $isOnline',
    );

    if (isOnline) {
      // Provider is online - start location stream if not already active
      if (serviceState is! ServiceLocationStreamActive &&
          serviceState is! ServiceLocationLoading) {
        debugPrint(
          '📍 [HomeScreenCubit] Provider is online - starting location stream',
        );
        // Ensure location is initialized first if needed
        if (serviceState is ServiceInitial ||
            serviceState is ServiceLocationError ||
            serviceState is ServiceLocationPermissionDenied) {
          serviceCubit.initializeLocation().then((_) {
            serviceCubit.startLocationStream();
          });
        } else {
          // Location already initialized, just start the stream
          serviceCubit.startLocationStream();
        }
      } else {
        debugPrint('📍 [HomeScreenCubit] Location stream already active');
      }
    } else {
      // Provider is offline - stop location stream
      if (serviceState is ServiceLocationStreamActive ||
          serviceState is ServiceLocationEnabled ||
          serviceState is ServiceLocationLoading) {
        debugPrint(
          '📍 [HomeScreenCubit] Provider is offline - stopping location stream',
        );
        serviceCubit.stopLocationStream();
      } else {
        debugPrint('📍 [HomeScreenCubit] Location stream already stopped');
      }
    }
  }

  // // for test
  // Future<void> checkSessionValidation() async {
  //   emit(ValidationLoadingState());
  //   await Future.delayed(Duration(seconds: 5));
  //
  //   bool isSuccess = Random().nextBool();
  //
  //   if (isSuccess) {
  //     emit(ValidatedSession());
  //   } else {
  //      emit(NotValidateSession());
  //   }
  // }
}
