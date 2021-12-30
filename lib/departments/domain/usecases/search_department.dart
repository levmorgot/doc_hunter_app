import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/departments/domain/entities/depatment_entity.dart';
import 'package:doc_hunter_app/departments/domain/repositories/department_repository.dart';
import 'package:doc_hunter_app/filials/domain/usecases/params/search_filial_params.dart';

class SearchDepartment extends UseCase<List<DepartmentEntity>, SearchFilialParams> {
  final IDepartmentRepository departmentRepository;

  SearchDepartment(this.departmentRepository);

  @override
  Future<Either<Failure, List<DepartmentEntity>>> call(
      SearchFilialParams params) async {
    return await departmentRepository.searchFilial(
        params.query, params.pageParams.limit, params.pageParams.skip);
  }
}
