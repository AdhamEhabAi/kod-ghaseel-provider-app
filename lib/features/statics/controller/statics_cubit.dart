import 'package:bloc/bloc.dart';
import 'package:kod_ghaseel_provider_app/core/errors/failures.dart';
import 'package:kod_ghaseel_provider_app/features/statics/data/models/statistics_response.dart';
import 'package:kod_ghaseel_provider_app/features/statics/data/repo/statics_repo.dart';
import 'package:meta/meta.dart';

part 'statics_state.dart';

class StaticsCubit extends Cubit<StaticsState> {
  final StaticsRepo _staticsRepo;

  StaticsCubit(this._staticsRepo) : super(StaticsInitial());

  StatisticsResponse? statisticsResponse;

  Future<void> getStatistics() async {
    emit(StaticsLoading());

    final result = await _staticsRepo.getStatistics();

    result.fold(
      (Failure failure) => emit(StaticsError(
        message: failure.message,
      )),
      (StatisticsResponse response) {
        statisticsResponse = response;
        emit(StaticsSuccess(statisticsResponse: response));
      },
    );
  }
}
