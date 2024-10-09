import 'package:cooking_friend/core/connection/sqflite_connection.dart';
import 'package:cooking_friend/features/recipe/data/datasources/i_recipe_sqflite_data_source.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
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
    return RecipeModel.fromJson(json.first);
  }

  @override
  Future<int> saveNewRecipe(RecipeModel recipe) async {
    final db = await SqfliteConnection.instance.database;
    return await db.insert(
        SqfliteRecipeTable.tableName.paramName, recipe.toJson());
  }

  @override
  Future<int> updateRecipe(RecipeModel recipe) {
    // TODO: implement updateRecipe
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteRecipe(int id) async {
    final db = await SqfliteConnection.instance.database;
    int count = await db.delete(SqfliteRecipeTable.tableName.paramName,
        where: '${SqfliteRecipeTable.id.paramName} = ?', whereArgs: [id]);
    return count > 0;
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
