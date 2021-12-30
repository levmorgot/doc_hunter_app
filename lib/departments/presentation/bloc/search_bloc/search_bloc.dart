import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/departments/domain/usecases/params/search_department_params.dart';
import 'package:doc_hunter_app/departments/domain/usecases/search_department.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_event.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentSearchBloc extends Bloc<DepartmentSearchEvent, DepartmentSearchState> {
  final SearchDepartment searchDepartment;

  DepartmentSearchBloc({required this.searchDepartment})
      : super(DepartmentSearchEmptyState()) {
    on<SearchDepartmentsEvent>((event, emit) async {
      emit(DepartmentSearchLoadingState());
      final failureOrDepartments = await searchDepartment(SearchDepartmentParams(
          pageParams: event.pageDepartmentParams, query: event.departmentQuery));

      emit(failureOrDepartments.fold(
            (failure) =>
            DepartmentSearchErrorState(message: _mapFailureMessage(failure)),
            (departments) => DepartmentSearchLoadedState(departments: departments)));
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
