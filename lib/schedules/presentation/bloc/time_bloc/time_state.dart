import 'package:doc_hunter_app/schedules/domain/entities/time_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class TimeEmptyState extends TimeState {}

class TimeLoadingState extends TimeState {}

class TimeLoadedState extends TimeState {
  final List<TimeEntity> times;

  const TimeLoadedState({required this.times});

  @override
  List<Object> get props => [times];
}

class TimeErrorState extends TimeState {
  final String message;

  const TimeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}