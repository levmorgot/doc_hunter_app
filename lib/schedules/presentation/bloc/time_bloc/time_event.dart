import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_time_params.dart';
import 'package:equatable/equatable.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class GetTimeEvent extends TimeEvent {
  final ScheduleTimeParams timeParams;

  const GetTimeEvent(this.timeParams);
}