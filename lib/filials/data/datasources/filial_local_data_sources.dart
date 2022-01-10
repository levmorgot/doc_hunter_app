import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/filials/data/models/filial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IFilialLocalDataSource {
  Future<List<FilialModel>> getLastFilialsFromCache();

  Future<String> getLastEdit();

  Future<void> filialToCache(List<FilialModel> filials);

  Future<void> lastEditToCache(String lastEdit);
}

const cacheFilialsList = 'CACHE_FILIALS_LIST';
const cacheFilialsLastEdit = 'CACHE_FILIALS_LAST_EDIT';

class FilialLocalDataSource implements IFilialLocalDataSource {
  final SharedPreferences sharedPreferences;

  FilialLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> filialToCache(List<FilialModel> filials) {
    final List<String> jsonFilialList =
        filials.map((filial) => json.encode(filial.toJson())).toList();
    sharedPreferences.setStringList(cacheFilialsList, jsonFilialList);
    return Future.value();
  }

  @override
  Future<List<FilialModel>> getLastFilialsFromCache() {
    final jsonFilialList = sharedPreferences.getStringList(cacheFilialsList);
    if (jsonFilialList != null && jsonFilialList.isNotEmpty) {
      try {
        return Future.value(jsonFilialList
            .map((filial) => FilialModel.fromJson(json.decode(filial)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else if (jsonFilialList != null && jsonFilialList.isEmpty) {
      return Future.value([]);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit() {
    final jsonDoctorLastEdit = sharedPreferences.getString(cacheFilialsLastEdit);
    if (jsonDoctorLastEdit != null && jsonDoctorLastEdit.isNotEmpty) {
      try {
        return Future.value(jsonDoctorLastEdit);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value("");
    }
  }

  @override
  Future<void> lastEditToCache(String lastEdit) {
    sharedPreferences.setString(cacheFilialsLastEdit, lastEdit);
    return Future.value();
  }
}
