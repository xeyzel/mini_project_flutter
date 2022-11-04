import 'package:mini_project_flutter/src/database/db_sqlite.dart';
import 'package:mini_project_flutter/src/models/news/bookmark_news_model.dart';
import 'package:mini_project_flutter/src/screens/sports/setting/setting.dart';
import 'package:mini_project_flutter/src/services/news_table_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  Iterable<BookmarkNewsModel> _news = [];

  Iterable<BookmarkNewsModel> get news => _news;
  final NewsTableService _newsTableService = NewsTableService(DbSqlite());

  Future<int> createNews(BookmarkNewsModel news) async {
    return await _newsTableService.createNews(news);
  }

  void _getNews() async {
    final theNews = await _newsTableService.getNews();
    _news = theNews.toList().reversed;
    notifyListeners();
  }
}
