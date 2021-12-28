import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';

abstract class IFilialRepository {
  Future<Either<Failure, List<FilialEntity>>> getAllFilials(
      int limit, int skip);

  Future<Either<Failure, List<FilialEntity>>> searchFilial(
      String query, int limit, int skip);
}
