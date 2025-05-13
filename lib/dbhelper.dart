import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model/kopi.dart';

class DBHelper {
  DBHelper._privateConstuctor();
  static final DBHelper instance = DBHelper._privateConstuctor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'mydatabase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
      CREATE TABLE coffe(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        img TEXT,
        harga INTEGER,
        rating REAL,
        deskripsi TEXT

      )''');
      },
    );
  }

  Future<void> insertCoffe(Coffe coffe) async {
    final db = await database;
    await db.insert('Coffe', coffe.toMap());
  }

  Future<List<Coffe>> getCoffe() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Coffe');
    return List.generate(maps.length, (i) {
      return Coffe.fromMap(maps[i]);
    });
  }

  Future<Coffe?> getCoffeByName(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Coffe',
      where: 'name = ?',
      whereArgs: [name],
    );
    if (maps.isEmpty) {
      return Coffe.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Coffe?> getCoffeById(int coffeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Coffe',
      where: 'id = ?',
      whereArgs: [coffeId],
    );
    if (maps.isEmpty) {
      return Coffe.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateCoffe(Coffe coffe) async {
    final db = await database;
    await db.update(
      'coffe',
      coffe.toMap(),
      where: 'name = ?',
      whereArgs: [coffe.nama],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
