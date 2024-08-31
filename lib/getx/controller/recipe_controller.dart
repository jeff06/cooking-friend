import 'package:cooking_friend/screens/recipe/widget/recipe_step.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  var steps = <RecipeStep>[const RecipeStep(0, true)].obs;
  var hiddenStepsCounter = 0;

  _addEmptyStep(int index) {
    steps.add(RecipeStep(index + 1, true));
  }

  _hideStep(int index) {
    steps[index] = const RecipeStep(-2, false);
    hiddenStepsCounter++;
  }

  manageEmptyStep(int index, String? newVal) {
    if (newVal == "") {
      _hideStep(index);
    } else if (index+1 >= steps.length - hiddenStepsCounter) {
      _addEmptyStep(index);
    }
  }
}
