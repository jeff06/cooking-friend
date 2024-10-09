import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart';

class RecipeIngredientEntity {
  int? idIngredient;
  int? idRecipe;
  String? ingredient;
  String? measuringUnit;
  double? quantity;
  int? ordering;

  RecipeIngredientEntity(this.idIngredient, this.idRecipe, this.ingredient,
      this.measuringUnit, this.quantity, this.ordering);

  RecipeIngredientModel toModel() {
    return RecipeIngredientModel(
        idIngredient, idRecipe, ingredient, measuringUnit, quantity, ordering);
  }
}
