import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class StorageIsarDataSource {
  Future<StorageModel?> getSingleStorageItem(int id);
  Future<List<StorageModel>> getAllStorageItemByFilter(String currentFilter);
}

const cachedStorage = 'CACHED_STORAGE';

class StorageLocalDataSourceImpl implements StorageIsarDataSource {
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
}
