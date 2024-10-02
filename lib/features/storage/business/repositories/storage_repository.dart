import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:dartz/dartz.dart';

abstract class StorageRepository {
  Future<Either<Failure, StorageEntity>> getSingleStorageItem({
    required int id,
  });

  Future<Either<Failure, List<StorageEntity>>> getAllStorageItemByFilter({
    required String currentFilter,
  });

  Future<Either<Failure, int>> saveNewStorageItem({
    required StorageModel storageItem,
  });
}
