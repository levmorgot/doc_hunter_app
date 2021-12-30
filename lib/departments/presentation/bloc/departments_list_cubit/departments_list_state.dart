import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DepartmentState extends Equatable {
  const DepartmentState();

  @override
  List<Object> get props => [];
}

class DepartmentEmptyState extends DepartmentState {
  @override
  List<Object> get props => [];
}

class DepartmentLoadingState extends DepartmentState {
  final List<DepartmentEntity> oldDepartmentsList;
  final bool isFirstFetch;

  const DepartmentLoadingState(this.oldDepartmentsList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldDepartmentsList];
}


class DepartmentLoadedState extends DepartmentState {
  final List<DepartmentEntity> departmentsList;

  const DepartmentLoadedState(this.departmentsList);

  @override
  List<Object> get props => [departmentsList];
}

class DepartmentErrorState extends DepartmentState {
  final String message;

  const DepartmentErrorState({required this.message});

  @override
  List<Object> get props => [message];
}