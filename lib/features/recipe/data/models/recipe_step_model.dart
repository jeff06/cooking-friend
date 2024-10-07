import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';

class RecipeStep extends RecipeStepEntity {
  RecipeStep(super.id, super.step, super.order);

  factory RecipeStep.fromJson(Map<String, Object?> json) {
    return RecipeStep(
      int.parse(json['id'].toString()),
      json['step'].toString(),
      int.parse(json['order'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['step'] = step;
    data['order'] = order;

    return data;
  }
}
