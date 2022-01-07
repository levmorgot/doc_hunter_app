import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/doctors/data/models/doctor_model.dart';
import 'package:http/http.dart' as http;

abstract class IDoctorRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors(int filialId, int filialCacheId, int limit, int skip);

  Future<List<DoctorModel>> searchDoctor(int filialId, int filialCacheId, String query, int limit, int skip);
}

class DoctorRemoteDataSource implements IDoctorRemoteDataSource {
  final http.Client client;

  DoctorRemoteDataSource({required this.client});

  @override
  Future<List<DoctorModel>> getAllDoctors(int filialId, int filialCacheId, int limit, int skip) async {
    return await _getDoctorsFromUrl(
        'http://89.108.83.99:8000/departments/$filialId-$filialCacheId/?limit=$limit&skip=$skip');
  }

  @override
  Future<List<DoctorModel>> searchDoctor(
  int filialId, int filialCacheId, String query, int limit, int skip) async {
    return await _getDoctorsFromUrl(
        'http://89.108.83.99:8000/departments/$filialId-$filialCacheId/?search_string=$query&limit=1000&skip=$skip');
  }

  Future<List<DoctorModel>> _getDoctorsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final doctors = json.decode(utf8.decode(response.bodyBytes));
      return (doctors as List)
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
