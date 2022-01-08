import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/schedules/data/datasources/schedule_remote_data_sources.dart';
import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';
import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';
import 'package:doc_hunter_app/schedules/domain/repositories/schedule_repository.dart';

class ScheduleRepository implements IScheduleRepository {
  final IScheduleRemoteDataSource remoteDataSource;

  ScheduleRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DateEntity>>> getAllDate(int filialId,
      int filialCacheId, int departmentId, int doctorId) async {
    try {
      final dates = await remoteDataSource.getAllDate(
          filialId, filialCacheId, departmentId, doctorId);
      return Right(dates);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TimeEntity>>> getAllTimeForDate(int filialId,
      int filialCacheId, int departmentId, int doctorId, String date) async {
    try {
      final times = await remoteDataSource.getAllTimeForDate(
          filialId, filialCacheId, departmentId, doctorId, date);
      return Right(times);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
