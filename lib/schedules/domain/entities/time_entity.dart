import 'package:equatable/equatable.dart';

class TimeEntity extends Equatable {
  final String time;

  const TimeEntity({
    required this.time,
  });

  @override
  List<Object?> get props => [time];
}
