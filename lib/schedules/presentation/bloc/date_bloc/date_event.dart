import 'package:doc_hunter_app/schedules/domain/usecases/params/schedule_date_params.dart';
import 'package:equatable/equatable.dart';

abstract class DateEvent extends Equatable {
  const DateEvent();

  @override
  List<Object> get props => [];
}

class GetDateEvent extends DateEvent {
  final ScheduleDateParams dateParams;

  const GetDateEvent(this.dateParams);
}