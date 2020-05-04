import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../infrastructure/yacht_repository.dart';
import '../domain/yacht.dart';

// This implementation of repository has a problem because the class keeps
// getting reinstantiated so the in memory list keeps dissappearing.
class YachtRepositorySqlite implements YachtRepository {
  static const String tableYacht = 'Yacht';

  static Future<Database> database() async {
    // Get a location for the database
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'yachts.db');

    // Open the database. If it doesn't exist create the database with tables
    return openDatabase(
      path,
      version: 1,
      onCreate: (
        Database db,
        int version,
      ) {
        return db.execute(
            'CREATE TABLE Yacht (id integer primary key autoincrement, name text not null, imo integer, length real)');
      },
    );
  }

  @override
  Future<List<Yacht>> selectYachts() async {
    print('RobBebb selectYachts');
    final db = await YachtRepositorySqlite.database();
    List<Map> maps = await db.query(
      YachtRepositorySqlite.tableYacht,
    );
    if (maps.length > 0) {
      return maps.map(
        (yacht) => Yacht.fromMap(yacht),
      ).toList();
    }
    return null;
  }

  Future<int> insertYacht(Yacht yacht) async {
    print('RobBebb insertYacht');
    final db = await YachtRepositorySqlite.database();
    int id = await db.insert(
      YachtRepositorySqlite.tableYacht,
      yacht.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<Yacht> selectYacht(int id) async {
    print('RobBebb selectYacht');
    final db = await YachtRepositorySqlite.database();
    List<Map> map = await db.query(
      YachtRepositorySqlite.tableYacht,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (map.length > 0) {
      return Yacht.fromMap(map.first);
    }
    return null;
  }

  Future<void> updateYacht(Yacht yacht) async {
    print('RobBebb updateYacht');
    final db = await YachtRepositorySqlite.database();
    Map<String, Object> values = yacht.toMap();
    db.update(YachtRepositorySqlite.tableYacht, values, where: 'id = ?',
      whereArgs: [yacht.id],);
  }

  Future<void> deleteYacht(int id) async {
    print('RobBebb deleteYacht');
    final db = await YachtRepositorySqlite.database();
    db.delete(
      YachtRepositorySqlite.tableYacht,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
