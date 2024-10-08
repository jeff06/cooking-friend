import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';

class RecipeEntity {
  final int? id;
  final String? name;
  final bool? isFavorite;

  RecipeEntity(this.id, this.name, this.isFavorite);

  RecipeModel toModel([int? newId]) {
    return RecipeModel(newId ?? id, name, isFavorite);
  }
}
