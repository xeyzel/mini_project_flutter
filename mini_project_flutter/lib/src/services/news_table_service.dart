import 'package:mini_project_flutter/src/database/db_sqlite.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

class NewsTableService {
  static const String _newsTable = DbSqlite.tableNews;
  final DbSqlite _dbSqlite;

  NewsTableService(this._dbSqlite);

  Future<int> createNews(BookmarkModel newsModel) async {
    try {
      final db = await _dbSqlite.db;
      await db.insert(
        _newsTable,
        newsModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<Iterable<BookmarkModel>> getNews() async {
    try {
      final db = await _dbSqlite.db;
      final rawNews = await db.query(_newsTable);
      final news = rawNews.map((news) => BookmarkModel.fromMap(news));
      return news;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteNews(String title) async {
    try {
      final db = await _dbSqlite.db;
      final affectedRows = await db.delete(
        _newsTable,
        where: 'title=?',
        whereArgs: [title],
      );
      return affectedRows;
    } catch (e) {
      return 0;
    }
  }
}
