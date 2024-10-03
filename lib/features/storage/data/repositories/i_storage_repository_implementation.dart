import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:dartz/dartz.dart';

abstract class IStorageRepositoryImplementation {
  Future<Either<Failure, StorageModel>> getSingleStorageItem({
    required int id,
  });

  Future<Either<Failure, bool>> deleteStorageItem({
    required int id,
  });

  Future<Either<Failure, List<StorageModel>>> getAllStorageItemByFilter({
    required String currentFilter,
  });

  Future<Either<Failure, int>> saveNewStorageItem({
    required StorageModel storageItem,
  });

  Future<Either<Failure, int>> updateStorageItem(
      {required StorageModel storageItem, required int currentId});
}
