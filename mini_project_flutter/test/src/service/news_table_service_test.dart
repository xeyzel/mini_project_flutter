import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project_flutter/src/database/db_sqlite.dart';
import 'package:mini_project_flutter/src/models/bookmark/bookmark_model.dart';

import 'package:mini_project_flutter/src/services/news_table_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group(
    'News Table Service',
    () {
      final newsTableService = NewsTableService(DbSqlite());

      test(
        'Create News',
        () async {
          final news = BookmarkModel(
            author: 'EXAZOR',
            description: 'this is description',
            title: 'this is title',
            note: 'hai',
            url:
                'https://sport.detik.com/sepakbola/bola-dunia/d-6386823/ibrahimovic-giroud-harus-masuk-skuad-prancis-di-piala-dunia-2022',
          );
          final result = await newsTableService.createNote(news);
          print(result);
        },
      );

      test(
        'Get News',
        () async {
          final news = await newsTableService.getNews();
          print(news);
        },
      );

      test(
        'Delete News',
        () async {
          final result = await newsTableService.deleteNews(1);
        },
      );
    },
  );
}
