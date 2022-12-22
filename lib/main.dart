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
        appBarTheme: AppBarTheme(
          backgroundColor: BoxDecorationStyles.newsPrimaryColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: BoxDecorationStyles.newsPrimaryColor),
        listTileTheme: ListTileThemeData(
          selectedTileColor: BoxDecorationStyles.newsPrimaryColor,
          selectedColor: Colors.white,
        ),
      ),
    );
  }
}
