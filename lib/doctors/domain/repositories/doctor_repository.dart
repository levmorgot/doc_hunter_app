import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';

abstract class IDoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors(
      int filialId, int filialCacheId, int departmentId, int limit, int skip);

  Future<Either<Failure, List<DoctorEntity>>> searchDoctor(
      int filialId, int filialCacheId, int departmentId, String query, int limit, int skip);
}
