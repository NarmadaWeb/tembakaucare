import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
    String path = join(await getDatabasesPath(), 'tobacco_expert.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
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
