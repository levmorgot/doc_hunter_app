import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';
import 'package:doc_hunter_app/doctors/domain/repositories/doctor_repository.dart';
import 'package:doc_hunter_app/doctors/domain/usecases/params/page_doctor_params.dart';

class GetAllDoctors extends UseCase<List<DoctorEntity>, PageDoctorParams> {
  final IDoctorRepository doctorRepository;

  GetAllDoctors(this.doctorRepository);

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(
      PageDoctorParams params) async {
    return await doctorRepository.getAllDoctors(params.filiaId, params.filialCacheId, params.departmentId,  params.limit, params.skip);
  }
}
