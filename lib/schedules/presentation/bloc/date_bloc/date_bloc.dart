import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/get_all_date.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_date_params.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_event.dart';
import 'package:doc_hunter_app/schedules/presentation/bloc/date_bloc/date_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  final GetAllDate getAllDate;

  DateBloc({required this.getAllDate}) : super(DateEmptyState()) {
    on<GetDateEvent>((event, emit) async {
      emit(DateLoadingState());
      final failureOrDates = await getAllDate(ScheduleDateParams(
          departmentId: event.dateParams.departmentId,
          doctorId: event.dateParams.doctorId,
          filiaId: event.dateParams.filiaId,
          filialCacheId: event.dateParams.filialCacheId));

      emit(failureOrDates.fold(
          (failure) => DateErrorState(message: _mapFailureMessage(failure)),
          (dates) => DateLoadedState(dates: dates)));
    });
    on<SelectDateEvent>((event, emit) async {
      var currentState = state;
      emit(DateLoadingState());
      emit(DateLoadedState(
          dates: (currentState as DateLoadedState).dates,
          selectedDate: event.selectedDate));
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
