import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/doctors/data/models/doctor_model.dart';
import 'package:http/http.dart' as http;

abstract class IDoctorRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors(
      int filialId, int filialCacheId, int departmentId);
}

class DoctorRemoteDataSource implements IDoctorRemoteDataSource {
  final http.Client client;

  DoctorRemoteDataSource({required this.client});

  @override
  Future<List<DoctorModel>> getAllDoctors(int filialId, int filialCacheId,
      int departmentId) async {
    return await _getDoctorsFromUrl(
        'https://registratura.volganet.ru/api/reservation/doctors?f=$filialId&s=$filialCacheId&d=$departmentId');
  }

  Future<List<DoctorModel>> _getDoctorsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final doctors = json.decode(response.body)['data'];
      return (doctors as List)
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
