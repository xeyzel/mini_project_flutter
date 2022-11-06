import 'package:mini_project_flutter/src/database/db_sqlite.dart';
import 'package:mini_project_flutter/src/models/news/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/services/news_table_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  Iterable<BookmarkModel> _news = [];

  Iterable<BookmarkModel> get news => _news;
  final NewsTableService _newsTableService = NewsTableService(DbSqlite());

  Future<int> createNews(BookmarkModel news) async {
    return await _newsTableService.createNews(news);
  }

  void getNews() async {
    final theNews = await _newsTableService.getNews();
    _news = theNews.toList().reversed;
    notifyListeners();
  }

  void deleteNews(String title) async {
    await _newsTableService.deleteNews(title);
    notifyListeners();
  }
}
