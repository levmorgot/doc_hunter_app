import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/departments/data/models/department_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDepartmentLocalDataSource {
  Future<List<DepartmentModel>> getLastDepartmentsFromCache(int filialId, int filialCacheId);

  Future<String> getLastEdit(int filialId, int filialCacheId);

  Future<void> departmentToCache(int filialId, int filialCacheId, List<DepartmentModel> departments);

  Future<void> lastEditToCache(
      int filialId, int filialCacheId, String lastEdit);
}

const cacheDepartmentsList = 'CACHE_DEPARTMENTS_LIST';
const cacheDepartmentsLastEdit = 'CACHE_DEPARTMENTS_LAST_EDIT';

class DepartmentLocalDataSource implements IDepartmentLocalDataSource {
  final SharedPreferences sharedPreferences;

  DepartmentLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> departmentToCache(int filialId, int filialCacheId, List<DepartmentModel> departments) {
    final List<String> jsonDepartmentList =
        departments.map((department) => json.encode(department.toJson())).toList();
    sharedPreferences.setStringList(cacheDepartmentsList + '$filialId-$filialCacheId', jsonDepartmentList);
    return Future.value();
  }

  @override
  Future<List<DepartmentModel>> getLastDepartmentsFromCache(int filialId, int filialCacheId) {
    final jsonDepartmentList = sharedPreferences.getStringList(cacheDepartmentsList + '$filialId-$filialCacheId');
    if (jsonDepartmentList != null && jsonDepartmentList.isNotEmpty) {
      try {
        return Future.value(jsonDepartmentList
            .map((department) => DepartmentModel.fromJson(json.decode(department)))
            .toList());
      } catch(e) {
        throw CacheException();
      }
    } else if (jsonDepartmentList != null && jsonDepartmentList.isEmpty) {
      return Future.value([]);
    } else {
    throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit(int filialId, int filialCacheId) {
    final jsonDepartmentLastEdit = sharedPreferences.getString(
        cacheDepartmentsLastEdit + '$filialId-$filialCacheId');
    if (jsonDepartmentLastEdit != null && jsonDepartmentLastEdit.isNotEmpty) {
      try {
        return Future.value(jsonDepartmentLastEdit);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value("");
    }
  }

  @override
  Future<void> lastEditToCache(int filialId, int filialCacheId, String lastEdit) {
    sharedPreferences.setString(
        cacheDepartmentsLastEdit + '$filialId-$filialCacheId',
        lastEdit);
    return Future.value();
  }
}
