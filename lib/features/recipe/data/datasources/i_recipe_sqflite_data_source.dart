import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';

abstract class IRecipeSqfliteDataSource {
  Future<RecipeModel?> getSingleRecipe(int id);
  Future<int> saveNewRecipe(RecipeModel recipe);
  Future<int> updateRecipe(RecipeModel recipe);
  Future<bool> deleteRecipe(int currentId);
  Future<List<RecipeModel>> getAllRecipeByFilter(String currentFilter);
}