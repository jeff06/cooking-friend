import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteConnection {
  static Database? _database;

  SqfliteConnection();

  static final SqfliteConnection instance = SqfliteConnection._init();

  SqfliteConnection._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cooking-friend.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    databaseFactory.setDatabasesPath('/storage/self/primary/Download');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE storage(id INTEGER PRIMARY KEY, name TEXT, date TEXT, code TEXT, quantity INT, location TEXT)');

    await db.execute(
        'CREATE TABLE recipe(id INTEGER PRIMARY KEY, title TEXT, isFavorite int)');
  }
}
