import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DoctorSearchState extends Equatable {
 const DoctorSearchState();

  @override
  List<Object> get props => [];
}

class DoctorSearchEmptyState extends DoctorSearchState {}

class DoctorSearchLoadingState extends DoctorSearchState {}

class DoctorSearchLoadedState extends DoctorSearchState {
  final List<DoctorEntity> doctors;

  const DoctorSearchLoadedState({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class DoctorSearchErrorState extends DoctorSearchState {
  final String message;

  const DoctorSearchErrorState({required this.message});

  @override
  List<Object> get props => [message];
}