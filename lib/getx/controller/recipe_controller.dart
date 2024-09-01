import 'package:cooking_friend/screens/recipe/widget/recipe_step.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  var steps = <RecipeStep>[RecipeStep()].obs;

  addEmptyStep(String guid) {
    int indexToInsert = steps.indexWhere((x) => x.guid == guid);
    steps.insert(indexToInsert + 1, RecipeStep());
  }

  hideStep(String guid) {
    steps.removeWhere((x) => x.guid == guid);
  }
}
