import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';

class RecipeStepEntity {
  final int id;
  final String? step;
  final int? order;

  RecipeStepEntity(this.id, this.step, this.order);
}
