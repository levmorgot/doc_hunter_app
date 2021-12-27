import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:doc_hunter_app/filials/domain/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/usecases/params/search_filial_params.dart';

class SearchFilial extends UseCase<List<FilialEntity>, SearchFilialParams> {
  final FilialRepository filialRepository;

  SearchFilial(this.filialRepository);

  @override
  Future<Either<Failure, List<FilialEntity>>> call(
      SearchFilialParams params) async {
    return await filialRepository.searchFilial(
        params.query, params.pageParams.limit, params.pageParams.skip);
  }
}
