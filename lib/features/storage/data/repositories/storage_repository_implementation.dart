import 'package:cooking_friend/core/errors/cache_exception.dart';
import 'package:cooking_friend/core/errors/cache_failure.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/data/datasources/i_storage_isar_data_source.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:dartz/dartz.dart';

class StorageRepositoryImplementation implements IStorageRepositoryImplementation {
  final IStorageIsarDataSource localDataSource;

  StorageRepositoryImplementation({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> deleteStorageItem(
      {required int id}) async {
    try {
      final localStorageItem = await localDataSource.deleteStorageItem(id);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }
  
  @override
  Future<Either<Failure, StorageModel>> getSingleStorageItem(
      {required int id}) async {
    try {
      final localStorageItem = await localDataSource.getSingleStorageItem(id);
      return Right(localStorageItem!);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, int>> saveNewStorageItem(
      {required StorageModel storageItem}) async {
    try {
      final localStorageItem =
          await localDataSource.saveNewStorageItem(storageItem);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, List<StorageModel>>> getAllStorageItemByFilter(
      {required String currentFilter}) async {
    try {
      final localStorageItem =
          await localDataSource.getAllStorageItemByFilter(currentFilter);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, int>> updateStorageItem(
      {required StorageModel storageItem, required int currentId}) async {
    try {
      final localStorageItem =
          await localDataSource.updateStorageItem(storageItem, currentId);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }
  
}
