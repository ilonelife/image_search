import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_search/model/album.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // late Album _album;
  Album? _album;

  // 오래 걸리는 처리,  비동기 처리
  Future<Album> fetchAlbum() async {
    // Future async await 함께  사용함..
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

      // 웹 응답코드 :
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // 정상이면, body를 가져와서 jsonDecode 처리하고 album을 만들어 리턴한다
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // fethAlbum 해서 album을 가져오고..이것을 _album 에 넣는다...
    super.initState();
    fetchAlbum().then((album) {
      setState(() {
        _album = album;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('test'),
        ),
        body: Container(
          child: Text(_album.toString()),
        ),
    );
  }
}
