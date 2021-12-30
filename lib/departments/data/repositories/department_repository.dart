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
      int limit, int skip) async {
    return _getDepartments(() {
      return remoteDataSource.getAllDepartments(limit, skip);
    });
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> searchDepartment(
      String query, int limit, int skip) async {
    return _getDepartments(() {
      return remoteDataSource.searchDepartment(query, limit, skip);
    });
  }

  Future<Either<Failure, List<DepartmentModel>>> _getDepartments(Future<List<DepartmentModel>> Function() getDepartments) async {
    if(await networkInfo.isConnected) {
      try {
        final remoteDepartments = await getDepartments();
        localDataSource.departmentToCache(remoteDepartments);
        return Right(remoteDepartments);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDepartments = await localDataSource.getLastDepartmentsFromCache();
        return Right(localDepartments);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
