import 'package:flutter/material.dart';

class NewsStrings {
  static const String appTitle = "News App";
  static const String appLangTitle = "Languages";
}

class NewsPadding {
  static const EdgeInsets newsPaddingAllMin = EdgeInsets.all(5);
  static const EdgeInsets newsPaddingAllLow = EdgeInsets.all(8.0);
  static const EdgeInsets newsPaddingAllMid = EdgeInsets.all(10.0);
  static const EdgeInsets newsPaddingAllHigh = EdgeInsets.all(15.0);

  static const EdgeInsets newsPaddingHorizontalMid =
      EdgeInsets.symmetric(horizontal: 10);

  static const EdgeInsets newsPaddingVerticalLow =
      EdgeInsets.symmetric(vertical: 5);

  static const EdgeInsets newsCategoriesPading = EdgeInsets.all(2);
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

 static Color newsPrimaryColor = Colors.red.shade300;

  static BoxDecoration boxShadow =
      BoxDecoration(color: newsPrimaryColor, boxShadow: [
    const BoxShadow(
      color: Colors.black,
      blurRadius: 10,
    ),
  ]);
}

class NewsSizedBoxes {
  static const SizedBox sizedBox10 = SizedBox(width: 10);
}
