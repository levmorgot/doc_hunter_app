import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/platform/network_info.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_local_data_sources.dart';
import 'package:doc_hunter_app/filials/data/datasources/filial_remote_data_sources.dart';
import 'package:doc_hunter_app/filials/data/models/filial_model.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:doc_hunter_app/filials/domain/repositories/filial_repository.dart';

class FilialRepository implements IFilialRepository {
  final FilialRemoteDataSource remoteDataSource;
  final FilialLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  FilialRepository(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<FilialEntity>>> getAllFilials(
      int limit, int skip) async {
    return _getFilials(() {
      return remoteDataSource.getAllFilials(limit, skip);
    });
  }

  @override
  Future<Either<Failure, List<FilialEntity>>> searchFilial(
      String query, int limit, int skip) async {
    return _getFilials(() {
      return remoteDataSource.searchFilial(query, limit, skip);
    });
  }

  Future<Either<Failure, List<FilialModel>>> _getFilials(Future<List<FilialModel>> Function() getFilials) async {
    if(await networkInfo.isConnected) {
      try {
        final remoteFilials = await getFilials();
        localDataSource.filialToCache(remoteFilials);
        return Right(remoteFilials);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localFilials = await localDataSource.getLastFilialsFromCache();
        return Right(localFilials);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
