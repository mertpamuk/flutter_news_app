import 'dart:io';

import 'package:dio/dio.dart';

import '../model/news_model.dart';

class NewsService {
  Future<List<NewsModel>?> fetchNews(String location) async {
    try {
      final response = await Dio().get(
          'https://api.thenewsapi.com/v1/news/all?api_token=Up3ck9GEnYJrqsdNykjm3sv1uSkIfNdIMhEOA5aO&language=$location');

      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data["data"];
        if (datas is List) {
          return datas.map((e) => NewsModel.fromJson(e)).toList();
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}