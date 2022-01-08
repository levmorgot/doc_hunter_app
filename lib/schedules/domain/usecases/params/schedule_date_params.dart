import 'package:equatable/equatable.dart';

class ScheduleDateParams extends Equatable {
  final int filiaId;
  final int filialCacheId;
  final int departmentId;
  final int doctorId;

  const ScheduleDateParams({
    required this.filiaId,
    required this.filialCacheId,
    required this.departmentId,
    required this.doctorId,
  });


  @override
  List<Object?> get props => [filiaId, filialCacheId, departmentId, doctorId];
}