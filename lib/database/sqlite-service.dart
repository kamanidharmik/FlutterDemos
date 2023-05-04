import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SqlDatabaseService {
  SqlDatabaseService();
  Database? database;
  var table = "demo";
  static final SqlDatabaseService db = SqlDatabaseService();

  Future<Database> get _database async {
    if (database != null) return database!;
    database = await initDB();
    return database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print("Directory Is : ${documentsDirectory.path}");
    String path = join(documentsDirectory.path, "TODODHARMIK.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER primary key,"
          "taskname TEXT"
          ")");
    });
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await _database;
    return db.query(table, orderBy: "id");
  }

  Future<int> createItem(String name) async {
    final db = await _database;

    final data = {
      'taskname': name,
    };
    final id = await db.insert(
      table,
      data,
    );
    print("Return Id $id");
    return id;
  }

  delete(int id) async {
    final db = await _database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
    getItems();
  }

  // Update an item by id
  Future<int> updatetask(int id, String taskname) async {
    final db = await _database;
    final data = {
      'taskname': taskname,
    };
    final result =
        await db.update(table, data, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
