import 'package:cooking_friend/features/storage/data/models/storage_model.dart';

abstract class IStorageSqfliteDataSource {
  Future<StorageModel?> getSingleStorageItem(int id);
  Future<List<StorageModel>> getAllStorageItemByFilter(String currentFilter);
  Future<int> saveNewStorageItem(StorageModel storageItem);
  Future<int> updateStorageItem(StorageModel storageItem);
  Future<bool> deleteStorageItem(int currentId);
}