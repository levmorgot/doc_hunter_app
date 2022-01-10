import 'package:equatable/equatable.dart';

class TimeEntity extends Equatable {
  final String time;
  final bool isFree;

  const TimeEntity({
    required this.time,
    required this.isFree,
  });

  @override
  List<Object?> get props => [time, isFree];
}
