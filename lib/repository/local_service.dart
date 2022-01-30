import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planety_app/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'db_ecom');
    final database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE carts(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          productId INTEGER,
          productName TEXT,
          productPhoto TEXT,
          productPrice INTEGER,
          productDiscount INTEGER,
          productQuantity INTEGER)
          """);
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();

    return _database;
  }

  getAllItems(String table) async {
    var conn = await database;
    return await conn?.query(table);
  }

  inserItem(String table, data) async {
    var conn = await database;
    return await conn?.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  updateItem(String table, String columnName, data) async {
    var conn = await database;
    return await conn?.update(table, data,
        where: '$columnName =?', whereArgs: [data['productId']]);
  }

  deleteItem(String table, int id) async {
    var conn = await database;
    return await conn?.rawDelete("DELETE FROM $table WHERE id = $id");
  }

  getItem(String table, String columnName, conditionalValue) async {
    var conn = await database;
    return await conn?.rawQuery(
        'SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }
}
