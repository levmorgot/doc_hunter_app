import 'package:doc_hunter_app/doctors/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel(
      {required id,
      required name,
      required departmentId,
      required filialId,
      required filialCashId})
      : super(
            id: id,
            name: name,
            departmentId: departmentId,
            filialId: filialId,
            filialCashId: filialCashId);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? json['dcode'],
      name: json['name'],
      departmentId: json['departmentId'] ?? -1,
      filialId: json['filialId'] ?? -1,
      filialCashId: json['filialCashId'] ?? json['cashId'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'departmentId': departmentId,
      'filialId': filialId,
      'filialCashId': filialCashId,
    };
  }
}
