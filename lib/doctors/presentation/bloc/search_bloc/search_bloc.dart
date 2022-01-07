import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/params/search_doctor_params.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/search_doctor.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_event.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorSearchBloc extends Bloc<DoctorSearchEvent, DoctorSearchState> {
  final SearchDoctor searchDoctor;

  DoctorSearchBloc({required this.searchDoctor})
      : super(DoctorSearchEmptyState()) {
    on<SearchDoctorsEvent>((event, emit) async {
      emit(DoctorSearchLoadingState());
      final failureOrDoctors = await searchDoctor(SearchDoctorParams(
          pageParams: event.pageDoctorParams, query: event.doctorQuery));

      emit(failureOrDoctors.fold(
            (failure) =>
            DoctorSearchErrorState(message: _mapFailureMessage(failure)),
            (doctors) => DoctorSearchLoadedState(doctors: doctors)));
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
