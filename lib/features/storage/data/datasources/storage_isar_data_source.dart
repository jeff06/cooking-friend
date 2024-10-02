import 'package:cooking_friend/features/storage/data/datasources/i_storage_isar_data_source.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

const cachedStorage = 'CACHED_STORAGE';

class StorageLocalDataSourceImpl implements IStorageIsarDataSource {
  late Future<Isar> db;

  StorageLocalDataSourceImpl() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          StorageModelSchema,
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<StorageModel?> getSingleStorageItem(int id) async {
    final isar = await db;
    return await isar.storageModels.filter().idEqualTo(id).findFirst();
  }

  @override
  Future<bool> deleteStorageItem(int currentId) async {
    final isar = await db;
    return await isar.writeTxn(
          () async {
        return await isar.storageModels.delete(currentId);
      },
    );
  }

  @override
  Future<List<StorageModel>> getAllStorageItemByFilter(
      String currentFilter) async {
    final isar = await db;

    if (currentFilter != "") {
      return await isar.storageModels
          .filter()
          .nameContains(currentFilter)
          .or()
          .codeContains(currentFilter)
          .findAll();
    }
    return await isar.storageModels.filter().nameIsNotEmpty().findAll();
  }

  @override
  Future<int> updateStorageItem(StorageModel storageItem, int currentId) async {
    final isar = await db;
    storageItem.id = currentId;
    return isar.writeTxnSync<int>(() => isar.storageModels.putSync(storageItem));
  }

  @override
  Future<int> saveNewStorageItem(StorageModel storageItem) async {
    final isar = await db;
    return isar.writeTxnSync<int>(() => isar.storageModels.putSync(storageItem));
  }
}
