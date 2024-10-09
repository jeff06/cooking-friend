import 'package:cooking_friend/core/connection/sqflite_connection.dart';
import 'package:cooking_friend/features/storage/data/datasources/i_storage_sqflite_data_source.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:cooking_friend/skeleton/constants.dart';

class StorageSqfliteDataSourceImpl implements IStorageSqfliteDataSource {
  StorageSqfliteDataSourceImpl() {
    SqfliteConnection();
  }

  @override
  Future<StorageModel?> getSingleStorageItem(int id) async {
    final db = await SqfliteConnection.instance.database;
    final List<Map<String, Object?>> json = await db.query(
        SqfliteStorageTable.tableName.paramName,
        where: '${SqfliteStorageTable.id.paramName} = ?',
        whereArgs: [id]);
    return StorageModel.fromJson(json.first);
  }

  @override
  Future<bool> deleteStorageItem(int currentId) async {
    final db = await SqfliteConnection.instance.database;
    int count = await db.delete(SqfliteStorageTable.tableName.paramName,
        where: '${SqfliteStorageTable.id.paramName} = ?',
        whereArgs: [currentId]);
    return count > 0;
  }

  @override
  Future<List<StorageModel>> getAllStorageItemByFilter(
      String currentFilter) async {
    final db = await SqfliteConnection.instance.database;

    final List<Map<String, Object?>> json = await db.query(
        SqfliteStorageTable.tableName.paramName,
        where:
            '${SqfliteStorageTable.name.paramName} like ? or ${SqfliteStorageTable.code.paramName} like ?',
        whereArgs: ['%$currentFilter%', '%$currentFilter%']);

    return json.map((x) => StorageModel.fromJson(x)).toList();
  }

  @override
  Future<int> updateStorageItem(StorageModel storageItem, int currentId) async {
    final db = await SqfliteConnection.instance.database;

    return await db.update(
        SqfliteStorageTable.tableName.paramName, storageItem.toJson(),
        where: '${SqfliteStorageTable.id.paramName} = ?',
        whereArgs: [currentId]);
  }

  @override
  Future<int> saveNewStorageItem(StorageModel storageItem) async {
    final db = await SqfliteConnection.instance.database;

    return await db.insert(
        SqfliteStorageTable.tableName.paramName, storageItem.toJson());
  }
}
