import 'package:sqflite/sqflite.dart';
import 'db_stub.dart'
    if (dart.library.html) 'db_web.dart'
    if (dart.library.io) 'db_mobile.dart';
import '../models/models.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final factory = await getDatabaseFactory();
    final path = await getDbPath(factory);

    return await factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        disease_name TEXT,
        symptoms TEXT,
        accuracy REAL,
        date TEXT
      )
    ''');
  }

  Future<int> insertHistory(History history) async {
    Database db = await database;
    return await db.insert('history', history.toMap());
  }

  Future<List<History>> getHistory() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('history', orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return History.fromMap(maps[i]);
    });
  }

  Future<void> deleteHistory(int id) async {
    Database db = await database;
    await db.delete('history', where: 'id = ?', whereArgs: [id]);
  }
}
