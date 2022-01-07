import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorEmptyState extends DoctorState {
  @override
  List<Object> get props => [];
}

class DoctorLoadingState extends DoctorState {
  final Map<String, List<DoctorEntity>> oldDoctors;
  final bool isFirstFetch;

  const DoctorLoadingState(this.oldDoctors, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldDoctors];
}


class DoctorLoadedState extends DoctorState {
  final Map<String, List<DoctorEntity>> doctorsList;
  final bool thatAll;

  const DoctorLoadedState(this.doctorsList, this.thatAll);

  @override
  List<Object> get props => [doctorsList];
}


class DoctorErrorState extends DoctorState {
  final String message;

  const DoctorErrorState({required this.message});

  @override
  List<Object> get props => [message];
}