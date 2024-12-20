import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:dartz/dartz.dart';

class StorageRepository {
  final IStorageRepositoryImplementation storageRepository;

  StorageRepository({required this.storageRepository});

  Future<Either<Failure, bool>> deleteStorageItem({
    required int id,
  }) async {
    return await storageRepository.deleteStorageItem(id: id);
  }

  Future<Either<Failure, StorageEntity>> getSingleStorageItem({
    required int id,
  }) async {
    return await storageRepository.getSingleStorageItem(id: id);
  }

  Future<Either<Failure, List<StorageEntity>>> getAllStorageItemByFilter({
    required String filter,
  }) async {
    return await storageRepository.getAllStorageItemByFilter(
        currentFilter: filter);
  }

  Future<Either<Failure, int>> saveNewStorageItem(
      {required StorageModel storageItem}) async {
    return await storageRepository.saveNewStorageItem(storageItem: storageItem);
  }

  Future<Either<Failure, int>> updateStorageItem(
      {required StorageModel storageItem, required int currentId}) async {
    return await storageRepository.updateStorageItem(
        storageItem: storageItem);
  }
}
