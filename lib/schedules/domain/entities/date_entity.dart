import 'package:equatable/equatable.dart';

class DateEntity extends Equatable {
  final String date;
  final String startInterval;
  final String endInterval;

  const DateEntity({
    required this.date,
    required this.startInterval,
    required this.endInterval,
  });

  @override
  List<Object?> get props => [date, startInterval, endInterval];
}
