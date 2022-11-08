import 'package:mini_project_flutter/src/database/db_sqlite.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/services/news_table_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  Iterable<BookmarkModel> _news = [];
  BookmarkModel? _bookmarkModel;

  BookmarkModel? get mark => _bookmarkModel;
  Iterable<BookmarkModel> get news => _news;
  final NewsTableService _newsTableService = NewsTableService(DbSqlite());

  Future<int> createNews(BookmarkModel news) async {
    return await _newsTableService.createNews(news);
  }

  Future<Iterable<BookmarkModel>> getNews() async {
    final theNews = await _newsTableService.getNews();
    _news = theNews.toList().reversed;
    notifyListeners();
    return theNews;
  }

  Future<int> deleteNews(BookmarkModel bookmarkModel) async {
    final affectedRows =
        await _newsTableService.deleteNews(bookmarkModel.title);
    reloadScreen(bookmarkModel.title);
    return affectedRows;
  }

  void searchNews(String title, String search) async {
    if (search.isEmpty) {
      getNews();
      return;
    }
    final theNews = await _newsTableService.getNews();
    final searchNews = theNews.where(
      (news) => news.title.toLowerCase().contains(search.toLowerCase()),
    );
    _news = searchNews;
    notifyListeners();
  }

  void reloadScreen(String title) {
    getNews();
  }

  void selectedNews(BookmarkModel mark) {
    _bookmarkModel = mark;
    notifyListeners();
  }
}
