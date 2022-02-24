import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_app/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('debugPrintIsHere: open db func');

      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) async {
            await db.execute(
              'CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING,'
              'note TEXT,'
              'date STRING,'
              'startTime STRING,'
              'endTime STRING,'
              'remind INTEGER,'
              'repeat STRING,'
              'color INTEGER,'
              'isCompleted INTEGER)',
            );
          },
        );
        debugPrint('debugPrintIsHere: database created');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static Future<int> insert(Task? task) async {
    debugPrint('debugPrintIsHere: insert func');

    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    debugPrint('debugPrintIsHere: delete func');

    return await _db!.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  static Future<int> deleteAll() async {
    debugPrint('debugPrintIsHere: delete All db func');
    return await _db!.delete(_tableName);
  }

  static Future<int> update(int id) async {
    debugPrint('debugPrintIsHere: update func');

    return await _db!.rawUpdate(
      '''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id =?
    ''',
      [1, id],
    );
  }

  static Future<List<Map<String, dynamic>>> query() async {
    debugPrint('debugPrintIsHere: query func');
    return await _db!.query(_tableName);
  }
}
