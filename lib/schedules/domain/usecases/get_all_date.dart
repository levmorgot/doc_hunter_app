import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';
import 'package:doc_hunter_app/schedules/domain/repositories/schedule_repository.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_date_params.dart';

class GetAllDate extends UseCase<List<DateEntity>, ScheduleDateParams> {
  final IScheduleRepository scheduleRepository;

  GetAllDate(this.scheduleRepository);

  @override
  Future<Either<Failure, List<DateEntity>>> call(ScheduleDateParams params) async {
    return await scheduleRepository.getAllDate(params.filiaId,
        params.filialCacheId, params.departmentId, params.doctorId);
  }
}
