import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/data/models/banner_response_model.dart';

import '../data/home_repo/home_repo.dart';
import '../data/models/CheckSessionValidationResponse.dart';
import '../data/models/provider_status_response.dart';

part 'home_screen_state.dart';

@injectable
class HomeScreenCubit extends Cubit<HomeScreenState> {
  Locale _currentLocale = const Locale('ar');
  final HomeRepo homeRepo;
  UserData? userData;

  HomeScreenCubit(this.homeRepo) : super(HomeScreenInitial()) {
    loadLanguage();
  }

  Locale get currentLocale => _currentLocale;
  List<BannerItem> sliderBanners = [];
  List<BannerItem> popupBanners = [];
  
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
    emit(ValidationLoadingState());
    final result = await homeRepo.checkSessionValidation();
    result.fold(
          (failure) => emit(NotValidateSession(message: failure.message)),
          (response)  async{
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
          }
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

      popupBanners = response.data
          .where((banner) => banner.displayType.toLowerCase() == 'popup')
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
      },
    );
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
