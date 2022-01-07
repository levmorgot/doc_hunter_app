import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/get_all_doctors.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/params/page_doctor_params.dart';
import 'package:doc_hunter_app/doctors/presentation/bloc/doctors_list_cubit/doctors_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsListCubit extends Cubit<DoctorState> {
  final GetAllDoctors getAllDoctors;
  final int limit;

  DoctorsListCubit({
    required this.getAllDoctors,
    required this.limit,
  }) : super(DoctorEmptyState());

  void loadDoctors(int filialId, int filialCacheId) async {
    if (state is DoctorLoadingState) return;

    final currentState = state;

    var oldDoctors = <DoctorEntity>[];
    if (currentState is DoctorLoadedState) {
      oldDoctors =
          currentState.doctorsList["$filialId-$filialCacheId"] ?? [];
    }

    final int skip = oldDoctors.length;

    emit(DoctorLoadingState({"$filialId-$filialCacheId": oldDoctors},
        isFirstFetch: skip == 0));

    final failureOrDoctors = await getAllDoctors(PageDoctorParams(
        skip: skip,
        limit: limit,
        filiaId: filialId,
        filialCacheId: filialCacheId));

    failureOrDoctors.fold(
        (failure) =>
            emit(DoctorErrorState(message: _mapFailureMessage(failure))),
        (doctor) {
      final doctors = (state as DoctorLoadingState).oldDoctors["$filialId-$filialCacheId"] ?? [];
      doctors.addAll(doctor.where((element) => !doctors.contains(element)));

      emit(doctors.isNotEmpty ? DoctorLoadedState({"$filialId-$filialCacheId": doctors}, doctor.isEmpty) : DoctorEmptyState());
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
