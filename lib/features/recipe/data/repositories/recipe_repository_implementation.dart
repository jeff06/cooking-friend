import 'package:cooking_friend/core/errors/cache_exception.dart';
import 'package:cooking_friend/core/errors/cache_failure.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/recipe/data/datasources/i_recipe_sqflite_data_source.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImplementation
    implements IRecipeRepositoryImplementation {
  final IRecipeSqfliteDataSource localDataSource;

  RecipeRepositoryImplementation({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, RecipeModel>> getSingleRecipe(
      {required int id}) async {
    try {
      final localStorageItem = await localDataSource.getSingleRecipe(id);
      return Right(localStorageItem!);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRecipe({required int id}) async {
    try {
      final localStorageItem = await localDataSource.deleteRecipe(id);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, List<RecipeModel>>> getAllRecipeByFilter(
      {required String currentFilter}) async {
    try {
      final localStorageItem =
          await localDataSource.getAllRecipeByFilter(currentFilter);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, int>> saveNewRecipe(
      {required RecipeModel recipe}) async {
    try {
      final localStorageItem =
          await localDataSource.saveNewRecipe(recipe);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }

  @override
  Future<Either<Failure, int>> updateRecipe(
      {required RecipeModel recipe, required List<int> ingredientsToRemove, required List<int> stepsToRemove}) async {
    try {
      final localStorageItem = await localDataSource.updateRecipe(recipe, ingredientsToRemove, stepsToRemove);
      return Right(localStorageItem);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'No local data found'));
    }
  }
}
