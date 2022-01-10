import 'package:doc_hunter_app/schedules/domain/entities/date_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DateState extends Equatable {
  const DateState();

  @override
  List<Object> get props => [];
}

class DateEmptyState extends DateState {}

class DateLoadingState extends DateState {}

class DateLoadedState extends DateState {
  final List<DateEntity> dates;
  final String? selectedDate;

  const DateLoadedState({required this.dates, this.selectedDate});

  @override
  List<Object> get props => [dates];
}

class DateErrorState extends DateState {
  final String message;

  const DateErrorState({required this.message});

  @override
  List<Object> get props => [message];
}