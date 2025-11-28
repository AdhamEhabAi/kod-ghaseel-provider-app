part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLanguageLoaded extends HomeScreenState {
  final Locale locale;
  HomeScreenLanguageLoaded(this.locale);
}

class HomeScreenLanguageChanged extends HomeScreenState {
  final Locale locale;
  HomeScreenLanguageChanged(this.locale);
}
class ValidatedSession extends HomeScreenState {
  final CheckSessionValidationResponse response;
  ValidatedSession({required this.response });
}
class ValidationLoadingState extends HomeScreenState{}
class NotValidateSession extends HomeScreenState {
  final String message;
  NotValidateSession({this.message = 'Session is not valid'});

}
class HomeBannersLoading extends HomeScreenState {}

class HomeBannersLoaded extends HomeScreenState {}

class HomeBannersError extends HomeScreenState {
  final String message;
  HomeBannersError({required this.message});
}

class ProviderStatusLoading extends HomeScreenState {}

class ProviderStatusLoaded extends HomeScreenState {
  final ProviderStatusResponse response;
  ProviderStatusLoaded({required this.response});
}

class ProviderStatusError extends HomeScreenState {
  final String message;
  ProviderStatusError({required this.message});
}