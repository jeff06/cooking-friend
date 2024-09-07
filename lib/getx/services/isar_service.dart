import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/storage/storage_item.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<StorageItem?> getSingleStorageItem(int id) async {
    final isar = await db;
    return await isar.storageItems.filter().idEqualTo(id).findFirst();
  }

  Future<Recipe?> getSingleRecipe(int id) async {
    final isar = await db;
    return await isar.recipes.filter().idEqualTo(id).findFirst();
  }

  Future<int> saveNewStorageItem(StorageItem storageItem) async {
    final isar = await db;
    return isar.writeTxnSync<int>(() => isar.storageItems.putSync(storageItem));
  }

  Future<int> saveNewRecipe(Recipe recipe) async {
    final isar = await db;
    recipe.steps.addAll(recipe.lstSteps);
    recipe.ingredients.addAll(recipe.lstIngredients);
    return isar.writeTxnSync<int>(() => isar.recipes.putSync(recipe));
  }

  Future<int> updateRecipe(Recipe recipe, int currentId) async {
    final isar = await db;
    recipe.id = currentId;

    return isar.writeTxnSync<int>(() {
      int id = isar.recipes.putSync(recipe);
      isar.recipeIngredients.putAllSync(recipe.lstIngredients);
      isar.recipeSteps.putAllSync(recipe.lstSteps);

      recipe.ingredients.saveSync();
      recipe.steps.saveSync();
      return id;
    });
  }

  Future<int> updateRecipeStep(RecipeStep step) async {
    final isar = await db;
    return isar.writeTxnSync<int>(() => isar.recipeSteps.putSync(step));
  }

  Future<int> updateStorageItem(StorageItem storageItem, int currentId) async {
    final isar = await db;
    storageItem.id = currentId;
    return isar.writeTxnSync<int>(() => isar.storageItems.putSync(storageItem));
  }

  Future<bool> deleteStorageItem(int currentId) async {
    final isar = await db;
    return await isar.writeTxn(
      () async {
        return await isar.storageItems.delete(currentId);
      },
    );
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<StorageItem>> getAllStorageItemByFilter(
      String currentFilter) async {
    final isar = await db;

    if (currentFilter != "") {
      return await isar.storageItems
          .filter()
          .nameContains(currentFilter)
          .or()
          .codeContains(currentFilter)
          .findAll();
    }
    return await isar.storageItems.filter().nameIsNotEmpty().findAll();
  }

  Future<List<Recipe>> getAllRecipeByFilter(String currentFilter) async {
    final isar = await db;

    if (currentFilter != "") {
      return await isar.recipes.filter().nameContains(currentFilter).findAll();
    }
    return await isar.recipes.filter().nameIsNotEmpty().findAll();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          StorageItemSchema,
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
}
