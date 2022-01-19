import 'package:flutter/material.dart';
import 'package:image_search/data/photo_api.dart';
import 'package:image_search/model/picture_result.dart';

class HomeViewModel with ChangeNotifier {
  List<Picture> pictures = [];

  PhotoApi _api;

  HomeViewModel(this._api);

  Future<void> fetchPhoto(String query) async {
    // 상태가 변화는 타이밍
    pictures = await _api.fetchPhotos(query);
    notifyListeners();
  }
}
