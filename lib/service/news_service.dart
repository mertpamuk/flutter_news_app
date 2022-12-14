
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:news_app/model/news_model.dart';

class NewssService {
  String baseUrl = 'https://api.thenewsapi.com/v1/news/all?api_token=Up3ck9GEnYJrqsdNykjm3sv1uSkIfNdIMhEOA5aO&language=tr';

  Future<List<NewsModel>?> fetchNews() async {
    final response = await Dio().get(baseUrl);

    if(response.statusCode == HttpStatus.ok){
      final _datas = response.data;

      if (_datas is List) {
        return _datas.map((e) => NewsModel.fromJson(e)).toList();
      }
    }else if(response.statusCode == HttpStatus.badRequest){}
    return null;
  }
}
