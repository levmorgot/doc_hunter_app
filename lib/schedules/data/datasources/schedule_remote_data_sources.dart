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
    var start = DateTime.now();
    var end = start.add(const Duration(days: 62));
    var data = await _getDataFromUrl(
        'https://registratura.volganet.ru/api/reservation/schedule?st=${_dateToString(start)}&en=${_dateToString(end)}&doctor=$doctorId&filialId=$filialId&cashlist=$filialCacheId&speclist=$departmentId');
    final freeDates = _filterFreeDate(data['intervals'] ?? []);
    return freeDates.map((date) {
      return DateModel.fromJson(date);
    }).toList();
  }

  String _dateToString(DateTime date) {
    final String stringDate = date.toString();
    return stringDate.substring(0, 4) +
        stringDate.substring(5, 7) +
        stringDate.substring(8, 10);
  }

  List<Map<String, dynamic>> _filterFreeDate(List<dynamic> dates) {
    return dates
        .where((date) => date['isFree'])
        .map((date) => {
              'date': date['workDate'],
              'startInterval': date['startInterval'],
              'endInterval': date['endInterval']
            })
        .toList();
  }

  @override
  Future<List<TimeModel>> getAllTimeForDate(int filialId, int filialCacheId,
      int departmentId, int doctorId, String date) async {
    var data = await _getDataFromUrl(
        'https://registratura.volganet.ru/api/reservation/intervals?st=$date&en=$date&spec=$departmentId&dcode=$doctorId&filialId=$filialId&cashlist=$filialCacheId&inFilials=$filialId');
    List<dynamic> times = data['workdates'][0][date][0]['intervals'];
    var aaa = times.map((time) => TimeModel.fromJson(time)).toList();
    return aaa;
  }


  Future<Map<String, dynamic>> _getDataFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'][0];
    } else {
      throw ServerException();
    }
  }
}
