import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:dartz/dartz.dart';

abstract class IRecipeRepositoryImplementation {
  Future<Either<Failure, RecipeModel>> getSingleRecipe({
    required int id,
  });

  Future<Either<Failure, int>> saveNewRecipe({required RecipeModel recipe});

  Future<Either<Failure, int>> updateRecipe({required RecipeModel recipe, required List<int> ingredientsToRemove, required List<int> stepsToRemove, });

  Future<Either<Failure, bool>> deleteRecipe({required int id});

  Future<Either<Failure, List<RecipeModel>>> getAllRecipeByFilter(
      {required String currentFilter});
}
