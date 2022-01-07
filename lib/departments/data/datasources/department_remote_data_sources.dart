import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/departments/data/models/department_model.dart';
import 'package:http/http.dart' as http;

abstract class IDepartmentRemoteDataSource {
  Future<List<DepartmentModel>> getAllDepartments(int filialId, int filialCacheId, int limit, int skip);

  Future<List<DepartmentModel>> searchDepartment(int filialId, int filialCacheId, String query, int limit, int skip);
}

class DepartmentRemoteDataSource implements IDepartmentRemoteDataSource {
  final http.Client client;

  DepartmentRemoteDataSource({required this.client});

  @override
  Future<List<DepartmentModel>> getAllDepartments(int filialId, int filialCacheId, int limit, int skip) async {
    return await _getDepartmentsFromUrl(
        'http://89.108.83.99:8000/departments/$filialId-$filialCacheId/?limit=$limit&skip=$skip');
  }

  @override
  Future<List<DepartmentModel>> searchDepartment(
  int filialId, int filialCacheId, String query, int limit, int skip) async {
    return await _getDepartmentsFromUrl(
        'http://89.108.83.99:8000/departments/$filialId-$filialCacheId/?search_string=$query&limit=1000&skip=$skip');
  }

  Future<List<DepartmentModel>> _getDepartmentsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final departments = json.decode(utf8.decode(response.bodyBytes));
      return (departments as List)
          .map((department) => DepartmentModel.fromJson(department))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
