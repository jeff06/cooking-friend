import 'package:cooking_friend/core/connection/sqflite_connection.dart';
import 'package:cooking_friend/features/recipe/data/datasources/i_recipe_sqflite_data_source.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_step_model.dart';
import 'package:cooking_friend/skeleton/constants.dart';

class RecipeSqfliteDataSourceImpl implements IRecipeSqfliteDataSource {
  RecipeSqfliteDataSourceImpl() {
    SqfliteConnection();
  }

  @override
  Future<RecipeModel?> getSingleRecipe(int id) async {
    final db = await SqfliteConnection.instance.database;
    final List<Map<String, Object?>> json = await db.query(
        SqfliteRecipeTable.tableName.paramName,
        where: '${SqfliteRecipeTable.id.paramName} = ?',
        whereArgs: [id]);
    RecipeModel recipe = RecipeModel.fromJson(json.first);
    recipe.steps = await getAllStepsForRecipeId(id);
    recipe.ingredients = await getAllIngredientsForRecipeId(id);
    return recipe;
  }

  Future<List<RecipeIngredientModel>> getAllIngredientsForRecipeId(
      int id) async {
    final db = await SqfliteConnection.instance.database;
    List<RecipeIngredientModel> ingredients = [];
    final List<Map<String, Object?>> json = await db.query(
      SqfliteRecipeIngredientTable.tableName.paramName,
      where: '${SqfliteRecipeIngredientTable.idRecipe.paramName} = ?',
      whereArgs: [id],
    );

    for (var x in json) {
      ingredients.add(RecipeIngredientModel.fromJson(x));
    }

    return ingredients;
  }

  Future<List<RecipeStepModel>> getAllStepsForRecipeId(int id) async {
    final db = await SqfliteConnection.instance.database;
    List<RecipeStepModel> steps = [];
    final List<Map<String, Object?>> json = await db.query(
      SqfliteRecipeStepTable.tableName.paramName,
      where: '${SqfliteRecipeStepTable.idRecipe.paramName} = ?',
      whereArgs: [id],
    );

    for (var x in json) {
      steps.add(RecipeStepModel.fromJson(x));
    }

    return steps;
  }

  @override
  Future<int> saveNewRecipe(RecipeModel recipe) async {
    final db = await SqfliteConnection.instance.database;
    int idRecipe = await db.insert(
        SqfliteRecipeTable.tableName.paramName, recipe.toJson());
    await saveNewRecipeSteps(
        recipe.steps!.map((x) => x.toModel()).toList(), idRecipe);
    await saveNewRecipeIngredients(
        recipe.ingredients!.map((x) => x.toModel()).toList(), idRecipe);
    return idRecipe;
  }

  Future saveNewRecipeSteps(List<RecipeStepModel> steps, int idRecipe) async {
    final db = await SqfliteConnection.instance.database;
    for (var v in steps) {
      v.idRecipe = idRecipe;
      await db.insert(SqfliteRecipeStepTable.tableName.paramName, v.toJson());
    }
  }

  Future saveNewRecipeIngredients(
      List<RecipeIngredientModel> ingredients, int idRecipe) async {
    final db = await SqfliteConnection.instance.database;
    for (var v in ingredients) {
      v.idRecipe = idRecipe;
      await db.insert(
          SqfliteRecipeIngredientTable.tableName.paramName, v.toJson());
    }
  }

  @override
  Future<int> updateRecipe(RecipeModel recipe, List<int> ingredientsToRemove,
      List<int> stepsToRemove) async {
    final db = await SqfliteConnection.instance.database;
    int id = await db.update(
        SqfliteRecipeTable.tableName.paramName, recipe.toJson());

    await deleteAllRecipeStepsByIds(stepsToRemove);
    await deleteAllRecipeIngredientsByIds(ingredientsToRemove);

    for (var v in recipe.steps!) {
      if (v.idStep == null) {
        await db.insert(
            SqfliteRecipeStepTable.tableName.paramName, v.toModel().toJson());
      } else {
        await db.update(
            SqfliteRecipeStepTable.tableName.paramName, v.toModel().toJson());
      }
    }

    for (var v in recipe.ingredients!) {
      if (v.idIngredient == null) {
        await db.insert(SqfliteRecipeIngredientTable.tableName.paramName,
            v.toModel().toJson());
      } else {
        await db.update(SqfliteRecipeIngredientTable.tableName.paramName,
            v.toModel().toJson());
      }
    }

    return id;
  }

  @override
  Future<bool> deleteRecipe(int id) async {
    final db = await SqfliteConnection.instance.database;
    int count = await db.delete(SqfliteRecipeTable.tableName.paramName,
        where: '${SqfliteRecipeTable.id.paramName} = ?', whereArgs: [id]);
    return count > 0;
  }

  Future deleteAllRecipeStepsByIds(List<int> stepsToRemove) async {
    final db = await SqfliteConnection.instance.database;
    for (var id in stepsToRemove) {
      await db.delete(SqfliteRecipeStepTable.tableName.paramName,
          where: '${SqfliteRecipeStepTable.id.paramName} = ?', whereArgs: [id]);
    }
  }

  Future deleteAllRecipeIngredientsByIds(List<int> ingredientsToRemove) async {
    final db = await SqfliteConnection.instance.database;
    for (var id in ingredientsToRemove) {
      await db.delete(SqfliteRecipeIngredientTable.tableName.paramName,
          where: '${SqfliteRecipeIngredientTable.id.paramName} = ?',
          whereArgs: [id]);
    }
  }

  @override
  Future<List<RecipeModel>> getAllRecipeByFilter(String currentFilter) async {
    final db = await SqfliteConnection.instance.database;
    final List<Map<String, Object?>> json = await db.query(
        SqfliteRecipeTable.tableName.paramName,
        where: '${SqfliteRecipeTable.title.paramName} like ?',
        whereArgs: ['%$currentFilter%']);
    return json.map((x) => RecipeModel.fromJson(x)).toList();
  }
}
