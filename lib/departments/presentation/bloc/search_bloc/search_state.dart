import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DepartmentSearchState extends Equatable {
 const DepartmentSearchState();

  @override
  List<Object> get props => [];
}

class DepartmentSearchEmptyState extends DepartmentSearchState {}

class DepartmentSearchLoadingState extends DepartmentSearchState {}

class DepartmentSearchLoadedState extends DepartmentSearchState {
  final List<DepartmentEntity> departments;

  const DepartmentSearchLoadedState({required this.departments});

  @override
  List<Object> get props => [departments];
}

class DepartmentSearchErrorState extends DepartmentSearchState {
  final String message;

  const DepartmentSearchErrorState({required this.message});

  @override
  List<Object> get props => [message];
}