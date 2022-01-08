import 'package:dartz/dartz.dart';
import 'package:doc_hunter_app/core/error/failure.dart';
import 'package:doc_hunter_app/core/usecases/usecase.dart';
import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';
import 'package:doc_hunter_app/schedules/domain/repositories/schedule_repository.dart';
import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_time_params.dart';

class GetAllTimeForDate extends UseCase<List<TimeEntity>, ScheduleTimeParams> {
  final IScheduleRepository scheduleRepository;

  GetAllTimeForDate(this.scheduleRepository);

  @override
  Future<Either<Failure, List<TimeEntity>>> call(ScheduleTimeParams params) async {
    return await scheduleRepository.getAllTimeForDate(params.filiaId,
        params.filialCacheId, params.departmentId, params.doctorId, params.date);
  }
}
