import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'model.dart';
import 'photo_repo.dart';

class MockRepo extends PhotoRepo {
  @override
  Future<List<Photo>> fetchPhotos(http.Client client) async {
    return compute(createPhotos, 400);
  }
}

List<Photo> createPhotos(int x) {
  return List.generate(
      x,
          (int i) => Photo(
          id: i,
          title: 'example $i',
          url: 'https://placeimg.com/640/480/tech/$i'));
}