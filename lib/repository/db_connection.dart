import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_ecom');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE carts(id INTEGER PRIMARY KEY, productId INTEGER, productName TEXT, productPhoto TEXT, productPrice INTEGER, productDiscount INTEGER, productQuantity INTEGER)");
  }
}
