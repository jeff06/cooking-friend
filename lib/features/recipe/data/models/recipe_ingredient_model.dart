import 'package:cooking_friend/features/recipe/business/entities/recipe_ingredient_entity.dart';

class RecipeIngredientModel extends RecipeIngredientEntity {
  RecipeIngredientModel(super.id, super.ingredient, super.measuringUnit,
      super.quantity, super.order);

  factory RecipeIngredientModel.fromJson(Map<String, Object?> json) {
    return RecipeIngredientModel(
        int.parse(json['id'].toString()),
        json['ingredient'].toString(),
        json['measuringUnit'].toString(),
        double.parse(json['quantity'].toString()),
        int.parse(json['order'].toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ingredient'] = ingredient;
    data['measuringUnit'] = measuringUnit;
    data['quantity'] = quantity;
    data['order'] = order;
    
    return data;
  }
}
