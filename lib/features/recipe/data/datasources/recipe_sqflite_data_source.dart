import 'package:cooking_friend/features/recipe/data/datasources/i_recipe_sqflite_data_source.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RecipeSqfliteDataSourceImpl implements IRecipeSqfliteDataSource {
  static Database? _database;

  RecipeSqfliteDataSourceImpl();

  static final RecipeSqfliteDataSourceImpl instance =
      RecipeSqfliteDataSourceImpl._init();

  RecipeSqfliteDataSourceImpl._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cooking-friend.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    databaseFactory.setDatabasesPath('/storage/self/primary/Download');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE storage(id INTEGER PRIMARY KEY, name TEXT, date TEXT, code TEXT, quantity INT, location TEXT) ');
  }

  @override
  Future<RecipeModel?> getSingleRecipe(int id) async {
    final db = await instance.database;
    final List<Map<String, Object?>> json =
        await db.query('recipe', where: 'id = ?', whereArgs: [id]);
    return RecipeModel.fromJson(json.first);
  }

  @override
  Future<int> saveNewRecipe(RecipeModel recipe) async {
    final db = await instance.database;
    return await db.insert('recipe', recipe.toJson());
  }

  @override
  Future<int> updateRecipe(RecipeModel recipe) {
    // TODO: implement updateRecipe
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteRecipe(int id) async {
    final db = await instance.database;
    int count = await db.delete('recipe', where: 'id = ?', whereArgs: [id]);
    return count > 0;
  }

  @override
  Future<List<RecipeModel>> getAllRecipeByFilter(String currentFilter) async {
    final db = await instance.database;
    final List<Map<String, Object?>> json = await db
        .query('recipe', where: 'name like ?', whereArgs: ['%$currentFilter%']);
    return json.map((x) => RecipeModel.fromJson(x)).toList();
  }
}
