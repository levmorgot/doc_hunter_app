import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/departments/domain/usecases/get_all_departments.dart';
import 'package:doc_hunter_app/departments/domain/usecases/params/page_department_params.dart';
import 'package:doc_hunter_app/departments/presentation/bloc/departments_list_cubit/departments_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentsListCubit extends Cubit<DepartmentState> {
  final GetAllDepartments getAllDepartments;
  final int limit;

  DepartmentsListCubit({required this.getAllDepartments, required this.limit})
      : super(DepartmentEmptyState());
  int skip = 0;

  void loadDepartments() async {
    if (state is DepartmentLoadingState) return;

    final currentState = state;

    var oldDepartments = <DepartmentEntity>[];
    if (currentState is DepartmentLoadedState) {
      oldDepartments = currentState.departmentsList;
    }

    emit(DepartmentLoadingState(oldDepartments, isFirstFetch: skip == 0));

    final failureOrDepartments =
        await getAllDepartments(PageDepartmentParams(skip: skip, limit: limit));

    failureOrDepartments.fold(
        (failure) =>
            emit(DepartmentErrorState(message: _mapFailureMessage(failure))),
        (department) {
      skip += limit;
      final departments = (state as DepartmentLoadingState).oldDepartmentsList;
      departments.addAll(department);
      emit(DepartmentLoadedState(departments));
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
