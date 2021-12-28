import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';
import 'package:doc_hunter_app/filials/domain/repositories/filial_repository.dart';
import 'package:doc_hunter_app/filials/domain/usecases/params/page_filial_params.dart';

class GetAllFilials extends UseCase<List<FilialEntity>, PageFilialParams> {
  final IFilialRepository filialRepository;

  GetAllFilials(this.filialRepository);

  @override
  Future<Either<Failure, List<FilialEntity>>> call(
      PageFilialParams params) async {
    return await filialRepository.getAllFilials(params.limit, params.skip);
  }
}
