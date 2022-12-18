import 'package:flutter/material.dart';

import '../constants/utils.dart';
import '../model/news_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required NewsModel? newsModel,
  })  : _newsModel = newsModel,
        super(key: key);

  final NewsModel? _newsModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape:
          RoundedRectangleBorder(borderRadius: NewsRadius.newsRadiusCircular),
      child: Padding(
        padding: NewsPadding.newsPaddingAllMid,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: NewsRadius.newsRadiusCircular,
              child: Image.network(_newsModel?.imageUrl ?? "",
                  errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              }),
            ),
            Padding(
              padding: NewsPadding.newsPaddingAllMid,
              child: Text(
                _newsModel?.title ?? "",
                style: NewsTextStyles.newsTitleTextStyle,
              ),
            ),
            Text(_newsModel?.description ?? ""),
          ],
        ),
      ),
    );
  }
}
