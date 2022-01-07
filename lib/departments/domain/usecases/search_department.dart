import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/departments/domain/repositories/department_repository.dart';
import 'package:doc_hunter_app/departments/domain/usecases/params/search_department_params.dart';

class SearchDepartment
    extends UseCase<List<DepartmentEntity>, SearchDepartmentParams> {
  final IDepartmentRepository departmentRepository;

  SearchDepartment(this.departmentRepository);

  @override
  Future<Either<Failure, List<DepartmentEntity>>> call(
      SearchDepartmentParams params) async {
    return await departmentRepository.searchDepartment(
        params.pageParams.filiaId,
        params.pageParams.filialCacheId,
        params.query,
        params.pageParams.limit,
        params.pageParams.skip);
  }
}
