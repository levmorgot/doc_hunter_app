import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/platform/network_info.dart';
import 'package:doc_hunter_app/doctors/data/datasources/doctor_local_data_sources.dart';
import 'package:doc_hunter_app/doctors/data/datasources/doctor_remote_data_sources.dart';
import 'package:doc_hunter_app/doctors/data/models/doctor_model.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/doctors/domain/repositories/doctor_repository.dart';

class DoctorRepository implements IDoctorRepository {
  final IDoctorRemoteDataSource remoteDataSource;
  final IDoctorLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  DoctorRepository(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors(int filialId,
      int filialCacheId, int departmentId, int limit, int skip) async {
    final allDoctors =
        await _getDoctors(filialId, filialCacheId, departmentId, () {
      return remoteDataSource.getAllDoctors(
          filialId, filialCacheId, departmentId);
    });
    return allDoctors.fold((failure) => Left(failure),
        (doctors) => Right(doctors.sublist(skip, skip + limit >= doctors.length ? null : skip + limit)));
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctor(
      int filialId,
      int filialCacheId,
      int departmentId,
      String query,
      int limit,
      int skip) async {
    final allDoctors =
        await _getDoctors(filialId, filialCacheId, departmentId, () {
      return remoteDataSource.getAllDoctors(
          filialId, filialCacheId, departmentId);
    });
    return allDoctors.fold(
        (failure) => Left(failure),
        (doctors) => Right(doctors
            .where((element) => element.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
            .sublist(skip, skip + limit >= doctors.length ? null : skip + limit)));
  }

  Future<Either<Failure, String>> _getLastEdit(
      int filialId, int filialCacheId, int departmentId) async {
    try {
      final lastEdit = await localDataSource.getLastEdit(
          filialId, filialCacheId, departmentId);
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<DoctorModel>>> _getDoctors(
      int filialId,
      int filialCacheId,
      int departmentId,
      Future<List<DoctorModel>> Function() getDoctors) async {
    final lastEdit = await _getLastEdit(filialId, filialCacheId, departmentId);
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteDoctors = await getDoctors();
          localDataSource.lastEditToCache(filialId, filialCacheId, departmentId,
              DateTime.now().toString().substring(0, 10));
          localDataSource.doctorToCache(
              filialId, filialCacheId, departmentId, remoteDoctors);
          return Right(remoteDoctors);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localFilials = await localDataSource.getLastDoctorsFromCache(
              filialId, filialCacheId, departmentId);
          return Right(localFilials);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }
}
