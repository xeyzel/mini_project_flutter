// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class SqfliteDatabase {
//   static Database? _myDatabase;
//   Future<Database?> get db async {
//     if (_myDatabase == null) {
//       _myDatabase = await initialDatabase();
//       return _myDatabase;
//     } else {
//       return _myDatabase;
//     }
//   }

//   initialDatabase() async {
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'my_database.db');
//     Database myDatabase = await openDatabase(
//       path,
//       version: 2,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );
//     return myDatabase;
//   }

//   FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
//     debugPrint('Database Upgrade');
//   }

//   FutureOr<void> _onCreate(db, version) async {
//     await db.execute(
//         'CREATE TABLE "bookmark" (id INTEGER PRIMARY KEY AUTOINCREMENT, "name" TEXT NOT NULL)');
//     debugPrint('Database created');
//   }

//   readData() async {
//     Database? myData = await db;
//     List<Map> myRead = await myData!.rawQuery('SELECT * FROM "bookmark"');
//     return myRead;
//   }

//   insertData(String name) async {
//     Database? myData = await db;
//     int myInsert = await myData!
//         .rawInsert('INSERT INTO "bookmark"("name") VALUES("$name")');
//     return myInsert;
//   }

//   updateData(String name, int id) async {
//     Database? myData = await db;
//     int myUpdate = await myData!
//         .rawUpdate('UPDATE "bookmark" SET "name" = "$name" WHERE id = $id');
//     return myUpdate;
//   }

//   deleteData(String id) async {
//     Database? myData = await db;
//     int myDelete =
//         await myData!.rawDelete('DELETE FROM "bookmark" WHERE id = $id');
//     return myDelete;
//   }
// }
