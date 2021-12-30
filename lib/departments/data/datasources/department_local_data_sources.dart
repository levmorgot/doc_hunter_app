import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/departments/data/models/department_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDepartmentLocalDataSource {
  Future<List<DepartmentModel>> getLastDepartmentsFromCache();

  Future<void> departmentToCache(List<DepartmentModel> departments);
}

const cacheDepartmentsList = 'CACHE_FILIALS_LIST';

class DepartmentLocalDataSource implements IDepartmentLocalDataSource {
  final SharedPreferences sharedPreferences;

  DepartmentLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> departmentToCache(List<DepartmentModel> departments) {
    final List<String> jsonDepartmentList =
        departments.map((department) => json.encode(department.toJson())).toList();
    sharedPreferences.setStringList(cacheDepartmentsList, jsonDepartmentList);
    return Future.value();
  }

  @override
  Future<List<DepartmentModel>> getLastDepartmentsFromCache() {
    final jsonDepartmentList = sharedPreferences.getStringList(cacheDepartmentsList);
    if (jsonDepartmentList != null && jsonDepartmentList.isNotEmpty) {
      try {
        return Future.value(jsonDepartmentList
            .map((department) => DepartmentModel.fromJson(json.decode(department)))
            .toList());
      } catch(e) {
        throw CacheException();
      }

    } else {
      throw CacheException();
    }
  }
}
