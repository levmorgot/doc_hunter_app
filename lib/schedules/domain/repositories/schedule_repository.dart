import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';
import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';

abstract class IScheduleRepository {
  Future<Either<Failure, List<DateEntity>>> getAllDate(
      int filialId, int filialCacheId, int departmentId, int doctorId);

  Future<Either<Failure, List<TimeEntity>>> getAllTimeForDate(
      int filialId, int filialCacheId, int departmentId, int doctorId, String date);
}
