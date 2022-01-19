import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_search/model/pixabay.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
//  String query = 'phogo';
//  List<Picture> photos = [];

  String url = 'https://pixabay.com/api/?'
      'key=24806095-fea70a37f71c6222b27afd5be&q=iphone&image_type=photo&pretty=true';

  // 검색어 입력값 처리
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 리스트 형태 데이터
  Future<List<Pixabay>> fetchPixabays() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Pixabay.listToPixabays(jsonDecode(response.body)['hits']);
    } else {
      throw Exception('Failed to load Pixabay');
    }
  }

  // 오래 걸리는 처리,  비동기 처리,
  Future<Pixabay> fetchPixabay() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // 정상이면, body를 가져와서 jsonDecode 처리하고 pixabay 만들어 리턴한다
      return Pixabay.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    late Future<Pixabay> futurePixabay;
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '검색어를 입력하세요',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String input = _searchController.text;
                    url =
                        'https://pixabay.com/api/?key=24806095-fea70a37f71c6222b27afd5be&'
                        'q=$input&image_type=photo&pretty=true';
                    setState(() {});
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<Pixabay>>(
              future: fetchPixabays(),
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
                final List<Pixabay> pixabays = snapshot.data!;
                // 최종 데이터를 표시하게 됨..
                return _buildPixabays(pixabays);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPixabays(List<Pixabay> pixabays) {
  return Expanded(
    child: ListView.builder(
      itemCount: pixabays.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Image.network(
              pixabays[index].previewURL,
              fit: BoxFit.cover,
            ),
            Text(pixabays[index].tags),
            const SizedBox(
              height: 20,
            )
          ],
        );
        //       ListTile(
        //       title: Text(pixabays[index].tags),
        //       leading: Image.network(pixabays[index].previewURL, fit: BoxFit.cover),
        //        );
      },
    ),
  );
}
