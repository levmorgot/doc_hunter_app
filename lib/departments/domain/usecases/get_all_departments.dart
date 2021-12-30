import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/departments/domain/repositories/department_repository.dart';
import 'package:doc_hunter_app/departments/domain/usecases/params/page_department_params.dart';

class GetAllDepartments extends UseCase<List<DepartmentEntity>, PageDepartmentParams> {
  final IDepartmentRepository departmentRepository;

  GetAllDepartments(this.departmentRepository);

  @override
  Future<Either<Failure, List<DepartmentEntity>>> call(
      PageDepartmentParams params) async {
    return await departmentRepository.getAllFilials(params.limit, params.skip);
  }
}
