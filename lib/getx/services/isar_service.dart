import 'package:cooking_friend/features/recipe/data/models/recipe.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_step.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  //#region Isar
  IsarService() {
    db = openDB();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          StorageModelSchema,
          RecipeSchema,
          RecipeIngredientSchema,
          RecipeStepSchema
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  //#endregion

  //#region Recipe

  Future<Recipe?> getSingleRecipe(int id) async {
    final isar = await db;
    return await isar.recipes.filter().idEqualTo(id).findFirst();
  }

  Future<int> saveNewRecipe(Recipe recipe) async {
    final isar = await db;
    recipe.steps.addAll(recipe.lstSteps);
    recipe.ingredients.addAll(recipe.lstIngredients);
    return isar.writeTxnSync<int>(() => isar.recipes.putSync(recipe));
  }

  Future<int> updateRecipe(Recipe recipe, int currentId, List<int> ingredientsToDelete, List<int> stepsToDelete) async {
    final isar = await db;

    recipe.id = currentId;
    recipe.steps.addAll(recipe.lstSteps);
    recipe.ingredients.addAll(recipe.lstIngredients);

    return isar.writeTxnSync<int>(() {
      int id = isar.recipes.putSync(recipe);
      isar.recipeIngredients.putAllSync(recipe.lstIngredients);
      isar.recipeSteps.putAllSync(recipe.lstSteps);

      isar.recipeIngredients.deleteAllSync(ingredientsToDelete);
      isar.recipeSteps.deleteAllSync(stepsToDelete);

      recipe.ingredients.saveSync();
      recipe.steps.saveSync();
      return id;
    });
  }

  Future<bool> deleteRecipe(int currentId) async {
    final isar = await db;
    return await isar.writeTxn(
      () async {
        return await isar.recipes.delete(currentId);
      },
    );
  }

  Future<List<Recipe>> getAllRecipeByFilter(String currentFilter) async {
    final isar = await db;

    if (currentFilter != "") {
      return await isar.recipes.filter().nameContains(currentFilter).findAll();
    }
    return await isar.recipes.filter().nameIsNotEmpty().findAll();
  }

  //#endregion
}
