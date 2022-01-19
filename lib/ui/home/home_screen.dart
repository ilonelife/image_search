import 'package:flutter/material.dart';
import 'package:image_search/ui/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textEditingController = TextEditingController();

  Future<void> _showResult(String query) async {
    context.read<HomeViewModel>().fetchPhoto(query);
  }

  @override
  void initState() {
    super.initState();
    // 한번 해야 하는 코드

    // initState에서 Context 접근 바로 안 됨
    // 여기까지는 context == null
    Future.microtask(() {
      // 아주 잠깐 딜레이
      // 여기부터는 context 가 null 아님
      _showResult('iphone');
    });
  }

  @override
  void dispose() {
    // 메모리 해제
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
              onPressed: () {
                _showResult(_textEditingController.text);
              },
              icon: const Icon(Icons.search),
            )),
          ),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              children: viewModel.pictures
                  .map((e) => Image.network(e.previewURL))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
