import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';

class RecipeStepModel extends RecipeStepEntity {
  RecipeStepModel(super.idStep, super.idRecipe, super.step, super.ordering);

  factory RecipeStepModel.fromJson(Map<String, Object?> json) {
    return RecipeStepModel(
      int.parse(json['idStep'].toString()),
      int.parse(json['idRecipe'].toString()),
      json['step'].toString(),
      int.parse(json['ordering'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idStep'] = idStep;
    data['idRecipe'] = idRecipe;
    data['step'] = step;
    data['ordering'] = ordering;

    return data;
  }
}
