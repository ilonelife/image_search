import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; //http는 클래스가 없고 탑레벨 함수로 구성되어 있음.. 그래서 http.get() 으로 호출함
import 'package:image_search/model/album.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // late Album _album;  아래 코드가 더 낫다??
  Album? _album;

  Future<void> init() async {
    Album album = await fetchAlbum();

    setState(() {
      _album = album;
    });
  }

  // 앨범 여러개 가져오기
  Future<List<Album>> fetchAlbums() async {
    // Future async await 함께  사용함..
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    // 웹 응답코드 :
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // 정상이면, body를 가져와서 jsonDecode 처리하고 album을 만들어 리턴한다
      return Album.listToAlbums(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

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
    init();
    // fetchAlbum().then((album) {
    //   setState(() {
    //     _album = album;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('앨범 가져오기'),
            ),
            FutureBuilder<Album>(
              // setState 없이  이 코드로 진행함...
              future: fetchAlbum(),
              builder: (context, snapshot) {
                // 에러가 있다면
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('네트워크 에러'),
                  );
                }
                // 연결 중이면
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // 데이터가 없다면
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('데이터가 없습니다'),
                  );
                }
                final Album album = snapshot.data!;
                // 최종 데이터를 표시하게 됨..
                return _buildBody(album);

                //   Text(
                //   '${album.id} : ${album.toString()}',
                //   style: const TextStyle(fontSize: 30.0),
                // );
              },
            ),
            Divider(
              color: Colors.indigo,
            ),
            FutureBuilder<List<Album>>(
              // setState 없이  이 코드로 진행함...
              future: fetchAlbums(),
              builder: (context, snapshot) {
                // 에러가 있다면
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return const Center(
                    child: Text('네트워크 에러'),
                  );
                }
                // 연결 중이면
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // 데이터가 없다면
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('데이터가 없습니다'),
                  );
                }
                final List<Album> albums = snapshot.data!;
                // 최종 데이터를 표시하게 됨..
                return _buildAlbums(albums);

                //   Text(
                //   '${album.id} : ${album.toString()}',
                //   style: const TextStyle(fontSize: 30.0),
                // );
              },
            ),
          ],
        ),
      ),
      // body: _album == null
      //     ? const Center(child: CircularProgressIndicator())
      //     : Text(
      //         '${_album!.id} : ${_album.toString()}',
      //         style: const TextStyle(fontSize: 30.0),
      //       ),
    );
  }
}

Widget _buildAlbums(List<Album> albums) {
  print('test');
  return Expanded(
    child: ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(albums[index].title),
        );
      },
    ),
  );
  // return Expanded(
  //   child: ListView(
  //     children: albums.map((e) => ListTile(title: Text(e.title),)).toList(),
  //   ),
  // );
}

Widget _buildBody(Album album) {
  return Text(
    '${album.id} : ${album.toString()}',
    style: const TextStyle(fontSize: 18.0),
  );
}
