import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final int id;
  final String name;
  final int departmentId;
  final int filialId;
  final int filialCashId;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.departmentId,
    required this.filialId,
    required this.filialCashId,
  });

  @override
  List<Object?> get props => [id, name, departmentId, filialId, filialCashId];
}
