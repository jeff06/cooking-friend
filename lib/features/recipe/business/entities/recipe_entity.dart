import 'package:cooking_friend/features/recipe/business/entities/recipe_ingredient_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';

class RecipeEntity {
  int? idRecipe;
  String? title;
  int? isFavorite;
  List<RecipeStepEntity>? steps;
  List<RecipeIngredientEntity>? ingredients;

  RecipeEntity(
      this.idRecipe, this.title, this.isFavorite, this.steps, this.ingredients);

  RecipeModel toModel([int? newId]) {
    return RecipeModel(
        newId ?? idRecipe, title, isFavorite, steps, ingredients);
  }
}
