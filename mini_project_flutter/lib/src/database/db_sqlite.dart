import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbSqlite {
  static Database? _myDatabase;
  static const tableNews = 'news';

  Future<Database> get db async {
    if (_myDatabase == null) {
      _myDatabase = await initialDatabase();
      return _myDatabase!;
    } else {
      return _myDatabase!;
    }
  }

  initialDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'play_ground_v5.db');
    Database myDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return myDatabase;
  }

  Future<void> _onCreate(db, version) async {
    await db.execute(
      '''
        CREATE TABLE $tableNews(
          idFromTable INTEGER PRIMARY KEY AUTOINCREMENT,
          author TEXT ,
          title TEXT ,
          description TEXT ,
          url TEXT ,
          note TEXT 
        )
      ''',
    );
  }
}
