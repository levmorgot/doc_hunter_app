import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/doctors/domain/repositories/doctor_repository.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/params/search_doctor_params.dart';

class SearchDoctor
    extends UseCase<List<DoctorEntity>, SearchDoctorParams> {
  final IDoctorRepository doctorRepository;

  SearchDoctor(this.doctorRepository);

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(
      SearchDoctorParams params) async {
    return await doctorRepository.searchDoctor(
        params.pageParams.filiaId,
        params.pageParams.filialCacheId,
        params.pageParams.departmentId,
        params.query,
        params.pageParams.limit,
        params.pageParams.skip);
  }
}
