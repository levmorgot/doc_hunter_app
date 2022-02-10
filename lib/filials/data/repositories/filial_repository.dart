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
  final IFilialRemoteDataSource remoteDataSource;
  final IFilialLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  FilialRepository(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<FilialEntity>>> getAllFilials(
      int limit, int skip) async {
    final allFilials = await _getFilials(() {
      return remoteDataSource.getAllFilials();
    });
    return allFilials.fold(
        (failure) => Left(failure),
        (filials) => Right(filials.sublist(
            skip, skip + limit >= filials.length ? null : skip + limit)));
  }

  @override
  Future<Either<Failure, List<FilialEntity>>> searchFilial(
      String query, int limit, int skip) async {
    final allFilials = await _getFilials(() {
      return remoteDataSource.getAllFilials();
    });
    return allFilials.fold(
        (failure) => Left(failure),
        (filials) => Right(filials
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()) ||
                element.address.toLowerCase().contains(query.toLowerCase()))
            .toList()));
  }

  Future<Either<Failure, String>> _getLastEdit() async {
    try {
      final lastEdit = await localDataSource.getLastEdit();
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<FilialModel>>> _getFilials(
      Future<List<FilialModel>> Function() getFilials) async {
    final lastEdit = await _getLastEdit();
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteFilials = await getFilials();
          localDataSource
              .lastEditToCache(DateTime.now().toString().substring(0, 10));
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
    });
  }
}
