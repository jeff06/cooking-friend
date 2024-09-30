import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StorageRepository {
  Future<Either<Failure, StorageEntity>> getSingleStorageItem({
    required int id,
});

  Future<Either<Failure, List<StorageEntity>>> getAllStorageItemByFilter({
    required String currentFilter,
  });
}