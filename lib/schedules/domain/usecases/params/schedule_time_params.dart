import 'package:equatable/equatable.dart';

class ScheduleTimeParams extends Equatable {
  final int filialId;
  final int filialCacheId;
  final int departmentId;
  final int doctorId;
  final String date;

  const ScheduleTimeParams({
    required this.filialId,
    required this.filialCacheId,
    required this.departmentId,
    required this.doctorId,
    required this.date,
  });


  @override
  List<Object?> get props => [filialId, filialCacheId, departmentId, doctorId, date];
}