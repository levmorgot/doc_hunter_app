import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/departments/domain/entities/depatment_entity.dart';

abstract class IDepartmentRepository {
  Future<Either<Failure, List<DepartmentEntity>>> getAllFilials(
      int limit, int skip);

  Future<Either<Failure, List<DepartmentEntity>>> searchFilial(
      String query, int limit, int skip);
}
