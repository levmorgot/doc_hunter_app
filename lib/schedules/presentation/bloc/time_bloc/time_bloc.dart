import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/get_all_time_for_date.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_time_params.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/time_bloc/time_event.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/time_bloc/time_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  final GetAllTimeForDate getAllTimeForDate;

  TimeBloc({required this.getAllTimeForDate}) : super(TimeEmptyState()) {
    on<GetTimeEvent>((event, emit) async {
      emit(TimeLoadingState());
      final failureOrDates = await getAllTimeForDate(ScheduleTimeParams(
          departmentId: event.timeParams.departmentId,
          doctorId: event.timeParams.doctorId,
          filialId: event.timeParams.filialId,
          filialCacheId: event.timeParams.filialCacheId,
          date: event.timeParams.date));

      emit(failureOrDates.fold(
          (failure) => TimeErrorState(message: _mapFailureMessage(failure)),
          (times) => TimeLoadedState(times: times)));
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
