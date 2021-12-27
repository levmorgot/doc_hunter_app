import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/filials/data/models/filial_model.dart';
import 'package:http/http.dart' as http;

abstract class IFilialRemoteDataSource {
  Future<List<FilialModel>> getAllFilials(int limit, int skip);

  Future<List<FilialModel>> searchFilial(String query, int limit, int skip);
}

class FilialRemoteDataSource implements IFilialRemoteDataSource {
  final http.Client client;

  FilialRemoteDataSource({required this.client});

  @override
  Future<List<FilialModel>> getAllFilials(int limit, int skip) async {
    return await _getFilialsFromUrl(
        'http://89.108.83.99:8000/filials/?limit=$limit&skip=$skip');
  }

  @override
  Future<List<FilialModel>> searchFilial(
      String query, int limit, int skip) async {
    return await _getFilialsFromUrl(
        'http://89.108.83.99:8000/filials/search/$query/?limit=$limit&skip=$skip');
  }

  Future<List<FilialModel>> _getFilialsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final filials = json.decode(response.body);
      return (filials as List)
          .map((filial) => FilialModel.fromJson(filial))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
