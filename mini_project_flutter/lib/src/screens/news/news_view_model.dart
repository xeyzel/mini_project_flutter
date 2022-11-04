import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/models/news/api/news_api.dart';
import 'package:mini_project_flutter/src/models/news/news_model.dart';

enum ActionState {
  none,
  loading,
  error,
}

class NewsViewModel extends ChangeNotifier {
  ActionState _state = ActionState.none;
  Iterable<NewsModel> _news = [];
  NewsModel? _newsModel;
  final NewsApi _newsApi = NewsApi();

  ActionState get state => _state;
  Iterable<NewsModel> get sportNews => _news;
  NewsModel? get news => _newsModel;

  NewsViewModel() {
    getSportNews();
  }

  Future<void> getSportNews() async {
    _changeState(ActionState.loading);

    try {
      final newsPaper = await _newsApi.getNewsData();
      _news = newsPaper;
      notifyListeners();
      _changeState(ActionState.none);
    } catch (e) {
      _changeState(ActionState.error);
    }
  }

  void _changeState(ActionState newState) {
    _state = newState;
    notifyListeners();
  }

  void selectedNews(NewsModel news) {
    _newsModel = news;
    notifyListeners();
  }
}
