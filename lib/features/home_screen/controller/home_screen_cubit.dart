import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';

import '../data/home_repo/home_repo.dart';
import '../data/models/CheckSessionValidationResponse.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  Locale _currentLocale = const Locale('ar');
  final HomeRepo homeRepo;

  HomeScreenCubit(this.homeRepo) : super(HomeScreenInitial()) {
    loadLanguage();
  }

  Locale get currentLocale => _currentLocale;

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
          (response) => emit(ValidatedSession(response: response)),
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
