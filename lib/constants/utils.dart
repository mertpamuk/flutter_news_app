import 'package:flutter/material.dart';

class NewsStrings {
  static const String appTitle = "News App";
  static const String appLangTitle = "Languages";
}

class NewsPadding {
  static const EdgeInsets newsPaddingAllLow = EdgeInsets.all(8.0);
  static const EdgeInsets newsPaddingAllMid = EdgeInsets.all(10.0);
  static const EdgeInsets newsPaddingAllHigh = EdgeInsets.all(15.0);

  static const EdgeInsets newsPaddingHorizontalMid =
      EdgeInsets.symmetric(horizontal: 10);
}

class NewsRadius {
  static BorderRadius newsRadiusCircular = BorderRadius.circular(20);
}

class NewsTextStyles {
  static const TextStyle drawerHeaderStyleMid =
      TextStyle(fontSize: 30, color: Colors.white);
  static const TextStyle drawerHeaderStyleLow =
      TextStyle(fontSize: 15, color: Colors.white);
  static const TextStyle newsTitleTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}

class BoxDecorationStyles {
  static const BoxDecoration boxShadow =
      BoxDecoration(color: Colors.blueAccent, boxShadow: [
    BoxShadow(
      color: Colors.black,
      blurRadius: 10,
    ),
  ]);
}

class NewsSizedBoxes {
  static const SizedBox sizedBox10 = SizedBox(width: 10);
}
