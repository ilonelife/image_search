import 'package:image_search/model/picture_result.dart';

// 공통 인터페이스
abstract class PhotoApi {
  Future<List<Picture>> fetchPhotos(String query);
}
