import 'dart:convert';

import 'model.dart';
import 'photo_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ProdRepo extends PhotoRepo {
  static const URL = 'https://jsonplaceholder.typicode.com/photos';

  @override
  Future<List<Photo>> fetchPhotos(http.Client client) async {
    final response = await client.get(URL);
    return compute(parseJson, response.body);
  }
}

List<Photo> parseJson(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}
