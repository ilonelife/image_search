import 'package:flutter/material.dart';
import 'package:image_search/data/pixabay_api.dart';
import 'package:image_search/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'ui/home/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(PixabayApi()),
          child: const HomeScreen(),
        )
        //SearchScreen() 내가 수정, //TestScreen(),   // HomeScreen() 오강사 버전
        );
  }
}
