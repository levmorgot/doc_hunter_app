import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/platform/network_info.dart';
import 'package:doc_hunter_app/departments/data/datasources/department_local_data_sources.dart';
import 'package:doc_hunter_app/departments/data/datasources/department_remote_data_sources.dart';
import 'package:doc_hunter_app/departments/data/models/department_model.dart';
import 'package:doc_hunter_app/departments/domain/entities/department_entity.dart';
import 'package:doc_hunter_app/departments/domain/repositories/department_repository.dart';

class DepartmentRepository implements IDepartmentRepository {
  final IDepartmentRemoteDataSource remoteDataSource;
  final IDepartmentLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  DepartmentRepository(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getAllDepartments(
      int filialId, int filialCacheId, int limit, int skip) async {
    final allDepartments = await _getDepartments(filialId, filialCacheId, () {
      return remoteDataSource.getAllDepartments(
          filialId, filialCacheId, limit, skip);
    });
    return allDepartments.fold(
        (failure) => Left(failure),
        (departments) => Right(departments.sublist(
            skip, skip + limit >= departments.length ? null : skip + limit)));
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> searchDepartment(int filialId,
      int filialCacheId, String query, int limit, int skip) async {
    final allDepartments = await _getDepartments(filialId, filialCacheId, () {
      return remoteDataSource.getAllDepartments(
          filialId, filialCacheId, limit, skip);
    });
    return allDepartments.fold(
        (failure) => Left(failure),
        (departments) => Right(departments
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
            .sublist(skip,
                skip + limit >= departments.length ? null : skip + limit)));
  }

  Future<Either<Failure, String>> _getLastEdit(
      int filialId, int filialCacheId) async {
    try {
      final lastEdit = await localDataSource.getLastEdit(
          filialId, filialCacheId);
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<DepartmentModel>>> _getDepartments(
      int filialId,
      int filialCacheId,
      Future<List<DepartmentModel>> Function() getDepartments) async {
    final lastEdit = await _getLastEdit(filialId, filialCacheId);
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteDoctors = await getDepartments();
          localDataSource.lastEditToCache(filialId, filialCacheId,
              DateTime.now().toString().substring(0, 10));
          localDataSource.departmentToCache(
              filialId, filialCacheId, remoteDoctors);
          return Right(remoteDoctors);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localFilials = await localDataSource.getLastDepartmentsFromCache(
              filialId, filialCacheId);
          return Right(localFilials);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });

  }
}
