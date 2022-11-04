import 'package:dio/dio.dart';
import 'package:mini_project_flutter/src/models/news/news_model.dart';

class NewsApi {
  final Dio _dio = Dio();
  static const baseUrl =
      'http://newsapi.org/v2/top-headlines?country=id&category=sports&apiKey=4eff343461ba4cae8917516ed1de7ecb';

  Future<Iterable<NewsModel>> getNewsData() async {
    try {
      var response = await _dio.get(baseUrl);
      var data = response.data['articles'] as List;
      return data.map((e) => NewsModel.fromJson(e));
    } catch (e) {
      rethrow;
    }
  }
}
