import 'package:cooking_friend/features/recipe/data/models/recipe_step_model.dart';

class RecipeStepEntity {
  int? idStep;
  int? idRecipe;
  String? step;
  int? ordering;

  RecipeStepEntity(this.idStep, this.idRecipe, this.step, this.ordering);

  RecipeStepModel toModel() {
    return RecipeStepModel(idStep, idRecipe, step, ordering);
  }
}
