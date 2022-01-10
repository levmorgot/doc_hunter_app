import 'dart:convert';

import 'package:doc_hunter_app/core/error/exception.dart';
import 'package:doc_hunter_app/filials/data/models/filial_model.dart';
import 'package:http/http.dart' as http;

abstract class IFilialRemoteDataSource {
  Future<List<FilialModel>> getAllFilials();
}

class FilialRemoteDataSource implements IFilialRemoteDataSource {
  final http.Client client;

  FilialRemoteDataSource({required this.client});

  @override
  Future<List<FilialModel>> getAllFilials() async {
    return await _getFilialsFromUrl(
        'https://registratura.volganet.ru/filial');
  }

  Future<List<FilialModel>> _getFilialsFromUrl(String url) async {
    print(url);
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final filials = json.decode(response.body)['data'];
      return (filials as List)
          .map((filial) => FilialModel.fromJson(filial))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
