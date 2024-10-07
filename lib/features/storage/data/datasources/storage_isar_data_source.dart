import 'package:cooking_friend/features/storage/data/datasources/i_storage_isar_data_source.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageLocalDataSourceImpl implements IStorageIsarDataSource {
  static Database? _database;

  StorageLocalDataSourceImpl();

  static final StorageLocalDataSourceImpl instance =
      StorageLocalDataSourceImpl._init();

  StorageLocalDataSourceImpl._init();

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
        'CREATE TABLE storage(id INTEGER PRIMARY KEY, name TEXT, date TEXT, code TEXT, quantity INT, location TEXT) ');
  }

  @override
  Future<StorageModel?> getSingleStorageItem(int id) async {
    final db = await instance.database;
    final List<Map<String, Object?>> json =
        await db.query('storage', where: 'id = ?', whereArgs: [id]);
    return StorageModel.fromJson(json.first);
  }

  @override
  Future<bool> deleteStorageItem(int currentId) async {
    final db = await instance.database;
    int count =
        await db.delete('storage', where: 'id = ?', whereArgs: [currentId]);
    return count > 0;
  }

  @override
  Future<List<StorageModel>> getAllStorageItemByFilter(
      String currentFilter) async {
    final db = await instance.database;

    final List<Map<String, Object?>> json = await db.query('storage',
        where: 'name like ? or code like ?',
        whereArgs: ['%$currentFilter%', '%$currentFilter%']);

    return json.map((x) => StorageModel.fromJson(x)).toList();
  }

  @override
  Future<int> updateStorageItem(StorageModel storageItem, int currentId) async {
    final db = await instance.database;

    return await db.update('storage', storageItem.toJson(),
        where: 'id = ?', whereArgs: [currentId]);
  }

  @override
  Future<int> saveNewStorageItem(StorageModel storageItem) async {
    final db = await instance.database;

    return await db.insert('storage', storageItem.toJson());
  }
}
