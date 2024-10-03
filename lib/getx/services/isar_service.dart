import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_step_model.dart';
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
          RecipeModelSchema,
          RecipeIngredientModelSchema,
          RecipeStepModelSchema
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  //#endregion

  //#region Recipe

  Future<RecipeModel?> getSingleRecipe(int id) async {
    final isar = await db;
    return await isar.recipeModels.filter().idEqualTo(id).findFirst();
  }

  Future<int> saveNewRecipe(RecipeModel recipe) async {
    final isar = await db;
    recipe.steps.addAll(recipe.lstSteps);
    recipe.ingredients.addAll(recipe.lstIngredients);
    return isar.writeTxnSync<int>(() => isar.recipeModels.putSync(recipe));
  }

  Future<int> updateRecipe(RecipeModel recipe, int currentId, List<int> ingredientsToDelete, List<int> stepsToDelete) async {
    final isar = await db;

    recipe.id = currentId;
    recipe.steps.addAll(recipe.lstSteps);
    recipe.ingredients.addAll(recipe.lstIngredients);

    return isar.writeTxnSync<int>(() {
      int id = isar.recipeModels.putSync(recipe);
      isar.recipeIngredientModels.putAllSync(recipe.lstIngredients);
      isar.recipeStepModels.putAllSync(recipe.lstSteps);

      isar.recipeIngredientModels.deleteAllSync(ingredientsToDelete);
      isar.recipeStepModels.deleteAllSync(stepsToDelete);

      recipe.ingredients.saveSync();
      recipe.steps.saveSync();
      return id;
    });
  }

  Future<bool> deleteRecipe(int currentId) async {
    final isar = await db;
    return await isar.writeTxn(
      () async {
        return await isar.recipeModels.delete(currentId);
      },
    );
  }

  Future<List<RecipeModel>> getAllRecipeByFilter(String currentFilter) async {
    final isar = await db;

    if (currentFilter != "") {
      return await isar.recipeModels.filter().nameContains(currentFilter).findAll();
    }
    return await isar.recipeModels.filter().nameIsNotEmpty().findAll();
  }

  //#endregion
}
