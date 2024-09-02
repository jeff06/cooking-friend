import 'package:cooking_friend/screens/recipe/widget/recipe_ingredient.dart';
import 'package:cooking_friend/screens/recipe/widget/recipe_step.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  var steps = <RecipeStep>[RecipeStep()].obs;
  var ingredients = <RecipeIngredient>[RecipeIngredient()].obs;

  addEmptyStep(String guid) {
    int indexToInsert = steps.indexWhere((x) => x.guid == guid);
    steps.insert(indexToInsert + 1, RecipeStep());
  }

  removeStep(String guid) {
    steps.removeWhere((x) => x.guid == guid);
  }

  addEmptyIngredient(String guid) {
    int indexToInsert = ingredients.indexWhere((x) => x.guid == guid);
    ingredients.insert(indexToInsert + 1, RecipeIngredient());
  }

  removeIngredient(String guid) {
    ingredients.removeWhere((x) => x.guid == guid);
  }
}
