import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_step_model.dart';
import 'package:isar/isar.dart';

part 'recipe_model.g.dart';

@collection
class RecipeModel {
  Id id = Isar.autoIncrement;
  String? name;
  bool? isFavorite;
  IsarLinks<RecipeStepModel> steps = IsarLinks<RecipeStepModel>();
  IsarLinks<RecipeIngredientModel> ingredients = IsarLinks<RecipeIngredientModel>();

  @ignore
  List<RecipeStepModel> lstSteps = [];
  @ignore
  List<RecipeIngredientModel> lstIngredients = [];
}
