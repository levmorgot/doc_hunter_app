import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/doctors/data/models/doctor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDoctorLocalDataSource {
  Future<List<DoctorModel>> getLastDoctorsFromCache();

  Future<void> doctorToCache(List<DoctorModel> doctors);
}

const cacheDoctorsList = 'CACHE_DEPARTMENTS_LIST';

class DoctorLocalDataSource implements IDoctorLocalDataSource {
  final SharedPreferences sharedPreferences;

  DoctorLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> doctorToCache(List<DoctorModel> doctors) {
    final List<String> jsonDoctorList =
        doctors.map((doctor) => json.encode(doctor.toJson())).toList();
    sharedPreferences.setStringList(cacheDoctorsList, jsonDoctorList);
    return Future.value();
  }

  @override
  Future<List<DoctorModel>> getLastDoctorsFromCache() {
    final jsonDoctorList = sharedPreferences.getStringList(cacheDoctorsList);
    if (jsonDoctorList != null && jsonDoctorList.isNotEmpty) {
      try {
        return Future.value(jsonDoctorList
            .map((doctor) => DoctorModel.fromJson(json.decode(doctor)))
            .toList());
      } catch(e) {
        throw CacheException();
      }

    } else {
      throw CacheException();
    }
  }
}
