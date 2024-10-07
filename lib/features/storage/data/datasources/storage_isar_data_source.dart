import 'package:cooking_friend/features/storage/data/datasources/i_storage_isar_data_source.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageLocalDataSourceImpl implements IStorageIsarDataSource {
  late Future<Database> db;

  StorageLocalDataSourceImpl() {
    db = openDB();
  }

  Future<Database> openDB() async {
    databaseFactory.setDatabasesPath('/storage/self/primary/Download');
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cooking-friend.db');
    // open the database
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE storage(id INTEGER PRIMARY KEY, name TEXT, date TEXT, code TEXT, quantity INT, location TEXT) ');
    });
  }

  @override
  Future<StorageModel?> getSingleStorageItem(int id) async {
    final sqflite = await db;
    final List<Map<String, Object?>> json =
        await sqflite.query('storage', where: 'id = ?', whereArgs: [id]);
    return StorageModel.fromJson(json.first);
  }

  @override
  Future<bool> deleteStorageItem(int currentId) async {
    final sqflite = await db;
    int count = await sqflite
        .delete('storage', where: 'id = ?', whereArgs: [currentId]);
    return count > 0;
  }

  @override
  Future<List<StorageModel>> getAllStorageItemByFilter(
      String currentFilter) async {
    final sqflite = await db;

    final List<Map<String, Object?>> json = await sqflite.query('storage',
        where: 'name like ? or code like ?',
        whereArgs: ['%$currentFilter%', '%$currentFilter%']);

    return json.map((x) => StorageModel.fromJson(x)).toList();
  }

  @override
  Future<int> updateStorageItem(StorageModel storageItem, int currentId) async {
    final sqflite = await db;

    return await sqflite.update('storage', storageItem.toJson(),
        where: 'id = ?', whereArgs: [currentId]);
    
  }

  @override
  Future<int> saveNewStorageItem(StorageModel storageItem) async {
    final sqflite = await db;
    
    return await sqflite.insert('storage', storageItem.toJson());
  }
}
