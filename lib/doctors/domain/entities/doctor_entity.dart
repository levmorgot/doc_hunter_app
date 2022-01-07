import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final int id;
  final String name;

  const DoctorEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
