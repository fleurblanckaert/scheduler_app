import 'package:scheduler_app/app/data/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_database != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'tasks.db';

      _database = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Creating a new Database...");
          return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT," 
            "title STRING, note TEXT, date STRING, startTime STRING, endTime STRING, color INTEGER, isCompleted INTEGER)",
          );

        }
      );
    } catch(e) {
      print(e);
    }
  }

  static Future<int> insert(Task task) async {
    print("Insert Function was called...");

    return await _database!.insert(_tableName, task.toJson());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function was called...");

    return await _database!.query(_tableName);
  }

  static Future<int> delete(Task task) async {
    return await _database!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static Future<int> updateStatusCompleted(int id) async {
    return await _database!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
    ''', [1, id]);
  }
}