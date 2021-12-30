import 'package:doc_hunter_app/departments/domain/usecases/params/page_department_params.dart';
import 'package:equatable/equatable.dart';

abstract class DepartmentSearchEvent extends Equatable {
  const DepartmentSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchDepartmentsEvent extends DepartmentSearchEvent {
  final String departmentQuery;
  final PageDepartmentParams pageDepartmentParams;

  const SearchDepartmentsEvent(this.departmentQuery, this.pageDepartmentParams);
}