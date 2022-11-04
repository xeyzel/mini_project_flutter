import 'package:dio/dio.dart';
import 'package:mini_project_flutter/src/models/sport/sport_model.dart';

class SportApi {
  final Dio _dio = Dio();
  static const baseUrl =
      'https://www.thesportsdb.com/api/v1/json/2/all_sports.php';

  Future<Iterable<SportModel>> getSportData() async {
    try {
      var response = await _dio.get(baseUrl);
      var data = response.data['sports'] as List;
      return data.map((e) => SportModel.fromJson(e));
    } catch (e) {
      rethrow;
    }
  }
}
