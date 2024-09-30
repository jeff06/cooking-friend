import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/business/repositories/storage_repository.dart';
import 'package:dartz/dartz.dart';

class GetStorage {
  final StorageRepository storageRepository;

  GetStorage({required this.storageRepository});

  Future<Either<Failure, StorageEntity>> getSingleStorageItem({
    required int id,
  }) async {
    return await storageRepository.getSingleStorageItem(id: id);
  }

  Future<Either<Failure, List<StorageEntity>>> getAllStorageItemByFilter({
    required String filter,
  }) async {
    return await storageRepository.getAllStorageItemByFilter(currentFilter: filter);
  }
  
}
