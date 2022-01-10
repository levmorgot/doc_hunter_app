import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/doctors/data/models/doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDoctorLocalDataSource {
  Future<List<DoctorModel>> getLastDoctorsFromCache(int filialId, int filialCacheId, int departmentId);

  Future<String> getLastEdit(int filialId, int filialCacheId, int departmentId);

  Future<void> doctorToCache(int filialId, int filialCacheId, int departmentId, List<DoctorModel> doctors);

  Future<void> lastEditToCache(
      int filialId, int filialCacheId, int departmentId, String lastEdit);
}

const cacheDoctorsList = 'CACHE_DOCTORS_LIST';
const cacheDoctorsLastEdit = 'CACHE_DOCTORS_LAST_EDIT';

class DoctorLocalDataSource implements IDoctorLocalDataSource {
  final SharedPreferences sharedPreferences;

  DoctorLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> doctorToCache(int filialId, int filialCacheId, int departmentId, List<DoctorModel> doctors) {
    final List<String> jsonDoctorList =
        doctors.map((doctor) => json.encode(doctor.toJson())).toList();
    sharedPreferences.setStringList(cacheDoctorsList + '$filialId-$filialCacheId-$departmentId', jsonDoctorList);
    return Future.value();
  }

  @override
  Future<List<DoctorModel>> getLastDoctorsFromCache(int filialId, int filialCacheId, int departmentId) {
    final jsonDoctorList = sharedPreferences.getStringList(cacheDoctorsList + '$filialId-$filialCacheId-$departmentId');
    if (jsonDoctorList != null && jsonDoctorList.isNotEmpty) {
      try {
        return Future.value(jsonDoctorList
            .map((doctor) => DoctorModel.fromJson(json.decode(doctor)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit(
      int filialId, int filialCacheId, int departmentId) {
    final jsonDoctorLastEdit = sharedPreferences.getString(
        cacheDoctorsLastEdit + '$filialId-$filialCacheId-$departmentId');
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
  Future<void> lastEditToCache(
      int filialId, int filialCacheId, int departmentId, String lastEdit) {
    sharedPreferences.setString(
        cacheDoctorsLastEdit + '$filialId-$filialCacheId-$departmentId',
        lastEdit);
    return Future.value();
  }
}
