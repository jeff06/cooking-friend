import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_step_model.dart';
import 'package:isar/isar.dart';

class RecipeEntity {
  final int? id;
  final IsarLinks<RecipeStepModel>? steps;
  final IsarLinks<RecipeIngredientModel>? ingredients;
  final String? name;
  final bool? isFavorite;

  RecipeEntity(
      this.id, this.steps, this.ingredients, this.name, this.isFavorite);
}
