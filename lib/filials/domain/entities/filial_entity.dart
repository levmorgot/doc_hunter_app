import 'package:equatable/equatable.dart';

class FilialEntity extends Equatable {
  final int id;
  final int cashId;
  final String name;
  final String address;
  final String phone;

  const FilialEntity({
    required this.id,
    required this.cashId,
    required this.name,
    required this.address,
    required this.phone
  });

  @override
  List<Object?> get props => [id, cashId, name, address, phone];
}