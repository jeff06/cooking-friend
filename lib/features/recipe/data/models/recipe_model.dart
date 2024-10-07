import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel(super.id, super.name, super.isFavorite);

  factory RecipeModel.fromJson(Map<String, Object?> json) {
    return RecipeModel(
      int.parse(json['id'].toString()),
      json['name'].toString(),
      bool.parse(json['isFavorite'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isFavorite'] = isFavorite;

    return data;
  }
}
