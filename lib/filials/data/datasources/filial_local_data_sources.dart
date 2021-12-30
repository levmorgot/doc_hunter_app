import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/filials/data/models/filial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IFilialLocalDataSource {
  Future<List<FilialModel>> getLastFilialsFromCache();

  Future<void> filialToCache(List<FilialModel> filials);
}

const cacheFilialsList = 'CACHE_FILIALS_LIST';

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
      } catch(e) {
        throw CacheException();
      }

    } else {
      throw CacheException();
    }
  }
}
