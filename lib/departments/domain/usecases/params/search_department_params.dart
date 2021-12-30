import 'package:doc_hunter_app/departments/domain/usecases/params/page_department_params.dart';
import 'package:equatable/equatable.dart';

class SearchDepartmentParams extends Equatable {
  final PageDepartmentParams pageParams;
  final String query;

  const SearchDepartmentParams({
    required this.pageParams,
    required this.query,
  });


  @override
  List<Object?> get props => [pageParams, query];
}