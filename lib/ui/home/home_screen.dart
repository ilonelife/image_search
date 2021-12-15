import 'package:flutter/material.dart';
import 'package:image_search/data/fake_data.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      // icon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                children: fakePhotos
                    .map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          e.previewURL,
                          fit: BoxFit.cover,
                        )))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
