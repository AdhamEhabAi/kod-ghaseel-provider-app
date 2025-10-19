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
