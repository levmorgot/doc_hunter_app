import 'package:doc_hunter_app/filials/domain/entities/filial_entity.dart';

class FilialModel extends FilialEntity {
  const FilialModel({required id,
    required cashId,
    required name,
    required address,
    required phone})
      : super(
    id: id,
    cashId: cashId,
    name: name,
    address: address,
    phone: phone,
  );

  factory FilialModel.fromJson(Map<String, dynamic> json) {
    return FilialModel(
      id: json['id'],
      cashId: json['cash_id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cashId': cashId,
      'name': name,
      'address': address,
      'phone': phone,
    };
  }
}
