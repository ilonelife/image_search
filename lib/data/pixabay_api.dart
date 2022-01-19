import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_search/model/picture_result.dart';

import 'photo_api.dart';

class PixabayApi implements PhotoApi {
  @override
  Future<List<Picture>> fetchPhotos(String query) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=17828481-17c071c7f8eadf406822fada3&q=$query&image_type=photo&per_page=100'));

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body)['hits'];
      return jsonList.map((e) => Picture.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Pixabay');
    }
  }
}
