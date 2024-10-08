import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel(super.id, super.title, super.isFavorite);

  factory RecipeModel.fromJson(Map<String, Object?> json) {
    return RecipeModel(
      int.parse(json['id'].toString()),
      json['title'].toString(),
      int.parse(json['isFavorite'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isFavorite'] = isFavorite;

    return data;
  }
}
