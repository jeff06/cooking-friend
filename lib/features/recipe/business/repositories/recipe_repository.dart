import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:dartz/dartz.dart';

class RecipeRepository {
  final IRecipeRepositoryImplementation recipeRepository;

  RecipeRepository({required this.recipeRepository});

  Future<Either<Failure, RecipeModel>> getSingleRecipe(
      {required int id}) async {
    return await recipeRepository.getSingleRecipe(id: id);
  }

  Future<Either<Failure, bool>> deleteRecipe({required int id}) async {
    return await recipeRepository.deleteRecipe(id: id);
  }

  Future<Either<Failure, List<RecipeModel>>> getAllRecipeByFilter(
      {required String currentFilter}) async {
    return await recipeRepository.getAllRecipeByFilter(
        currentFilter: currentFilter);
  }

  Future<Either<Failure, int>> saveNewRecipe(
      {required RecipeModel recipe}) async {
    return await recipeRepository.saveNewRecipe(recipe: recipe);
  }

  Future<Either<Failure, int>> updateRecipe(
      {required RecipeModel recipe}) async {
    return await recipeRepository.updateRecipe(recipe: recipe);
  }
}
