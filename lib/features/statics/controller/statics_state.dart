part of 'statics_cubit.dart';

@immutable
sealed class StaticsState {}

final class StaticsInitial extends StaticsState {}

final class StaticsLoading extends StaticsState {}

final class StaticsSuccess extends StaticsState {
  final StatisticsResponse statisticsResponse;

  StaticsSuccess({required this.statisticsResponse});
}

final class StaticsError extends StaticsState {
  final String message;

  StaticsError({required this.message});
}