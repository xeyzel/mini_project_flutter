import 'package:mini_project_flutter/src/database/db_sqlite.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_flutter/src/services/news_table_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  Iterable<BookmarkModel> _news = [];
  String _note = '';
  BookmarkModel? _bookmarkModel;

  String get note => _note;
  BookmarkModel? get mark => _bookmarkModel;
  Iterable<BookmarkModel> get news => _news;
  final NewsTableService _newsTableService = NewsTableService(DbSqlite());

  // CREATE
  Future<int> createNote(BookmarkModel news) async {
    return await _newsTableService.createNote(news);
  }

  // GET
  Future<Iterable<BookmarkModel>> getNews() async {
    final theNews = await _newsTableService.getNews();
    _news = theNews.toList().reversed;
    notifyListeners();
    return theNews;
  }

  // UPDATE
  Future<int> updateNote(BookmarkModel bookmarkModel) async {
    final affectedRows = await _newsTableService.updateNote(bookmarkModel);
    reloadScreen(bookmarkModel.title);
    return affectedRows;
  }

  // DELETE
  Future<int> deleteNews(BookmarkModel bookmarkModel) async {
    final affectedRows =
        await _newsTableService.deleteNews(bookmarkModel.idFromTable!);

    reloadScreen(bookmarkModel.title);
    return affectedRows;
  }

  // SEARCH
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

  void notes(String notes) {
    _note = notes;
    notifyListeners();
  }
}
