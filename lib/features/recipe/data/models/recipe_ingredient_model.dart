import 'package:cooking_friend/features/recipe/business/entities/recipe_ingredient_entity.dart';

class RecipeIngredientModel extends RecipeIngredientEntity {
  RecipeIngredientModel(super.idIngredient, super.idRecipe, super.ingredient,
      super.measuringUnit, super.quantity, super.ordering);

  factory RecipeIngredientModel.fromJson(Map<String, Object?> json) {
    return RecipeIngredientModel(
        int.parse(json['idIngredient'].toString()),
        int.parse(json['idRecipe'].toString()),
        json['ingredient'].toString(),
        json['measuringUnit'].toString(),
        double.parse(json['quantity'].toString()),
        int.parse(json['ordering'].toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idIngredient'] = idIngredient;
    data['idRecipe'] = idRecipe;
    data['ingredient'] = ingredient;
    data['measuringUnit'] = measuringUnit;
    data['quantity'] = quantity;
    data['ordering'] = ordering;

    return data;
  }
}
