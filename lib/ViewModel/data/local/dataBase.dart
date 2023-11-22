import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DioHelper {
  static Database? db;

  static Future<Database> initDb() async {
    return db = await openDatabase("jarjirDb.db", version: 1,
        onCreate: (Database db, int version) async {
      await createTable(db);
      debugPrint("DbCreated");
    });
  }

  static Future<void> createTable(Database db) async {
    await db.execute("""
    CREATE TABLE plants(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT
      )
      """);
    //debugPrint("table Created");
  }

  // add Plant
  static Future<int> addPlant(String title, String description) async {
    final db = await DioHelper.initDb();
    final data = {'title': title, 'description': description};
    final id = await db.insert("plants", data);
    return id;
  }

  // get All plants
  static Future<List<Map<String, dynamic>>> getAllPlant() async {
    final db = await DioHelper.initDb();
    return db.query("plants", orderBy: "id");
  }

  //get single  plant
  static Future<List<Map<String, dynamic>>> getPlant(int id) async {
    final db = await DioHelper.initDb();
    return db.query("plants", where: "id = ?", whereArgs: [id]);
  }

  // Update Single Plant
  static Future<int> upDatePlant(
      int id, String title, String description) async {
    final db = await DioHelper.initDb();
    final data = {'title': title, 'description': description};

    final updatedPlant =
        await db.update("plants", data, where: "id = ?", whereArgs: [id]);

    return updatedPlant;
  }

  static Future<void> deletePlant(int id) async {
    final db = await DioHelper.initDb();

    try {
      await db.delete('plants', where: "id=?", whereArgs: [id]);
    } catch (error) {
      debugPrint("error Deleting");
    }
  }

  static Future close() async => db?.close();
}
