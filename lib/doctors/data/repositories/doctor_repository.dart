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
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors(
      int filialId, int filialCacheId, int departmentId, int limit, int skip) async {
    return _getDoctors(() {
      return remoteDataSource.getAllDoctors(filialId, filialCacheId, departmentId, limit, skip);
    });
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctor(int filialId,
      int filialCacheId, int departmentId, String query, int limit, int skip) async {
    return _getDoctors(() {
      return remoteDataSource.searchDoctor(filialId, filialCacheId, departmentId, query, limit, skip);
    });
  }

  Future<Either<Failure, List<DoctorModel>>> _getDoctors(
      Future<List<DoctorModel>> Function() getDoctors) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDoctors = await getDoctors();
        localDataSource.doctorToCache(remoteDoctors);
        return Right(remoteDoctors);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return const Right(<DoctorModel>[]);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
