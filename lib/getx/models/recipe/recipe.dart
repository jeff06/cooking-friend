import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart';
import 'package:isar/isar.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  Id id = Isar.autoIncrement;
  String? name;
  IsarLinks<RecipeStep> steps = IsarLinks<RecipeStep>();
  IsarLinks<RecipeIngredient> ingredients = IsarLinks<RecipeIngredient>();

  @ignore
  List<RecipeStep> lstSteps = [];
  @ignore
  List<RecipeIngredient> lstIngredients = [];
}
