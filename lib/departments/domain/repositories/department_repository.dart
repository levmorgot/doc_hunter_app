import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';

abstract class IDepartmentRepository {
  Future<Either<Failure, List<DepartmentEntity>>> getAllDepartments(
      int filialId, int filialCacheId, int limit, int skip);

  Future<Either<Failure, List<DepartmentEntity>>> searchDepartment(
      int filialId, int filialCacheId, String query, int limit, int skip);
}
