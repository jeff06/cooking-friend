import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';

class RecipeEntity {
  final int? id;
  final String? title;
  final int? isFavorite;

  RecipeEntity(this.id, this.title, this.isFavorite);

  RecipeModel toModel([int? newId]) {
    return RecipeModel(newId ?? id, title, isFavorite);
  }
}
