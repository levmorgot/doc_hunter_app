import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  final int id;
  final String name;

  const DepartmentEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
