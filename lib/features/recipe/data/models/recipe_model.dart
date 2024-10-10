import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel(super.idRecipe, super.title, super.isFavorite, super.steps,
      super.ingredients);

  factory RecipeModel.fromJson(Map<String, Object?> json) {
    return RecipeModel(
        int.parse(json['idRecipe'].toString()),
        json['title'].toString(),
        int.parse(json['isFavorite'].toString()),
        null,
        null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRecipe'] = idRecipe;
    data['title'] = title;
    data['isFavorite'] = isFavorite;

    return data;
  }
}
