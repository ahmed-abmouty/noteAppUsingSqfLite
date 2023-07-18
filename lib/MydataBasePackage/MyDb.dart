import 'dart:async';

import 'package:note_app_using_sqflite/helpers/Constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
    } else
      return _db;
  }

  intialDb() async {
    String dataBasepath = await getDatabasesPath();
    String path = join(dataBasepath, kNoteDbName);
    Database db = await openDatabase(path,
        onCreate: _onCreate, onUpgrade: _onUpgrade, version: 1);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
//create tables
    await db.execute('''
    CREATE TABLE $kTableNotes (
    $kIdNoteCoulumn INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    $kTextNoteCoulumn TEXT NOTE NULL
    );
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<int> insertData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawInsert(sql);
  }

  Future<List<Map>> selectData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawQuery(sql);
  }

  Future<int> updateData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawDelete(sql);
  }
}