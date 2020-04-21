import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    // Get a location for the database
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'seadays.db');

    // Open the database. If it doesn't exist create the database with tables
    return openDatabase(
      path,
      version: 1,
      onCreate: (
        Database db,
        int version,
      ) {
        return db.execute(
            'CREATE TABLE Yacht (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, imo INTEGER, length real)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> values) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db =await DBHelper.database();
    return db.query(table);
  }
}
