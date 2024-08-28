import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/storage_item.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<StorageItem?> getSingleStorageItem(int id) async {
    final isar = await db;
    return await isar.storageItems.filter().idEqualTo(id).findFirst();
  }

  Future<void> saveNewStorageItem(StorageItem storageItem) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.storageItems.putSync(storageItem));
  }

  Future<void> updateStorageItem(StorageItem storageItem, int currentId) async {
    final isar = await db;
    storageItem.id = currentId;
    isar.writeTxnSync<int>(() => isar.storageItems.putSync(storageItem));
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<StorageItem?>> getAllStorageItemByFilter(
      String currentFilter) async {
    final isar = await db;

    if (currentFilter != "") {
      return await isar.storageItems
          .filter()
          .nameContains(currentFilter)
          .or()
          .codeContains(currentFilter)
          .findAll();
    }
    return await isar.storageItems.filter().nameIsNotEmpty().findAll();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [StorageItemSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
