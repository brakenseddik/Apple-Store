import 'package:http/http.dart' as http;
import 'package:planety_app/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  String baseUrl = "http://192.168.1.2:8000/api/";
  late DatabaseConnection _connection;

  Repository() {
    _connection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _connection.initDatabase();

    return _database;
  }

  httpGet(String api) async {
    return await http.get(Uri.parse(baseUrl + api));
  }

  httpPost(String api, data) async {
    return await http.post(Uri.parse(baseUrl + api), body: data);
  }

  httpGetById(String api, int id) async {
    return await http.get(Uri.parse(baseUrl + api + "/" + id.toString()));
  }

  getAllLocal(table) async {
    var conn = await database;
    return await conn!.query(table);
  }

  saveLocal(table, data) async {
    var conn = await database;
    return await conn!.insert(table, data);
  }

  updateLocal(table, columnName, data) async {
    var conn = await database;
    return await conn!.update(table, data,
        where: '$columnName =?', whereArgs: [data['productId']]);
  }

  deleteLocal(table, id) async {
    var conn = await database;
    return await conn!.rawDelete("DELETE FROM $table WHERE id = $id");
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var conn = await database;
    return await conn!.rawQuery(
        'SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }
}
