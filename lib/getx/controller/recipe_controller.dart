import 'package:cooking_friend/screens/recipe/widget/recipe_step.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  var steps = <RecipeStep>[const RecipeStep()].obs;

  addEmptySteps() {
    steps.add(const RecipeStep());
  }
}
