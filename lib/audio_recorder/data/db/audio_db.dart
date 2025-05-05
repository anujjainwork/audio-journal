import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AudioDatabase {
  static final AudioDatabase _instance = AudioDatabase._internal();
  factory AudioDatabase() => _instance;
  AudioDatabase._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'audio.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE audio (
        audioId TEXT PRIMARY KEY,
        clipName TEXT NOT NULL,
        audioPath TEXT NOT NULL,
        createdTime TEXT NOT NULL,
        tag TEXT NOT NULL
      )
    ''');
  }
}