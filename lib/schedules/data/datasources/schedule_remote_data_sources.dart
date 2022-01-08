import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/schedules/data/models/date_model.dart';
import 'package:doc_hunter_app/schedules/data/models/time_model.dart';
import 'package:http/http.dart' as http;

abstract class IScheduleRemoteDataSource {
  Future<List<DateModel>> getAllDate(
      int filialId, int filialCacheId, int departmentId, int doctorId);

  Future<List<TimeModel>> getAllTimeForDate(int filialId, int filialCacheId,
      int departmentId, int doctorId, String date);
}

class ScheduleRemoteDataSource implements IScheduleRemoteDataSource {
  final http.Client client;

  ScheduleRemoteDataSource({required this.client});

  @override
  Future<List<DateModel>> getAllDate(
      int filialId, int filialCacheId, int departmentId, int doctorId) async {
    var data = await _getDataFromUrl(
        'http://89.108.83.99:8000/schedule/$filialId-$filialCacheId-$departmentId-$doctorId/dates');
    return data.map((date) => DateModel.fromJson(date)).toList();
  }

  @override
  Future<List<TimeModel>> getAllTimeForDate(int filialId, int filialCacheId,
      int departmentId, int doctorId, String date) async {
    var data = await _getDataFromUrl(
        'http://89.108.83.99:8000/schedule/$filialId-$filialCacheId-$departmentId-$doctorId-$date/times');
    return data.map((time) => TimeModel.fromJson(time)).toList();
  }

  Future<List<dynamic>> _getDataFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw ServerException();
    }
  }
}
