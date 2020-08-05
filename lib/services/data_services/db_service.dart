import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sqfl;
import 'package:path/path.dart' as path;

import '../../resources/constants.dart';

class DBService {
  
  static Future<sqfl.Database> _getDatabase() async {
    final dbPath = await sqfl.getDatabasesPath();
    return sqfl.openDatabase(path.join(dbPath, dbName), onCreate: (db, version) async {
      await db.execute('CREATE TABLE ${DBTablesNames.fileEntries}(${DBFileEntryTableFieldsNames.id} INTEGER PRIMARY KEY, ${DBFileEntryTableFieldsNames.dateModified} INTEGER, ${DBFileEntryTableFieldsNames.fileName} TEXT)');
      return db.execute('CREATE TABLE ${DBTablesNames.atmosphericPressures}(${DBFileEntryTableFieldsNames.id} INTEGER PRIMARY KEY, ${DBAtmPressuresTableFieldsNames.date} INTEGER, ${DBAtmPressuresTableFieldsNames.pressure} INTEGER)');
    }, version: 1,);
  }

  static Future<List<Map<String, dynamic>>> selectAllFrom({@required String table, String sortOrder = 'DESC'}) async {
    if (sortOrder != 'DESC' && sortOrder != 'ASC') {
      sortOrder = 'DESC';
    }
    final db = await DBService._getDatabase();
    if (table == DBTablesNames.fileEntries) {
      return db.query(table, orderBy: '${DBFileEntryTableFieldsNames.dateModified} $sortOrder');
    }
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> selectOneFrom({@required String table, @required int byId}) async {
    final db = await DBService._getDatabase();
    return db.query(table, where: '${DBFileEntryTableFieldsNames.id} = ?', whereArgs: [byId]);
  }

  static Future<int> insert({@required String table, @required Map<String, Object> data}) async {
    final db = await DBService._getDatabase();
    return db.insert(table, data);
  }

  static Future<int> deleteFrom({@required String table, @required int byId}) async {
    final db = await DBService._getDatabase();
    return db.delete(table, where: '${DBFileEntryTableFieldsNames.id} = ?', whereArgs: [byId]);
  }
}