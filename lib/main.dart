import 'package:flutter/material.dart';
import 'package:news_app/view/home_view.dart';

import 'constants/utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: NewsStrings.appTitle,
      home: const HomeView(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blueAccent),
        listTileTheme:  const ListTileThemeData(
          selectedTileColor: Colors.blueAccent,
          selectedColor: Colors.white,
        ),
      ),
    );
  }
}
