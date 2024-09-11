import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_modification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('modifyLstStorageItemDisplayed', () {
    test('Do nothing', () {
      //arrange
      RecipeController controller = RecipeController();
      List<RecipeModification> lst = [];

      //act
      controller.modifyLstStorageItemDisplayed(lst);

      //assert
      expect(controller.lstRecipe.length, 0);
    });
    test('Add one', () {
      //arrange
      RecipeController controller = RecipeController();
      List<RecipeModification> lst = [];
      RecipeModification item = RecipeModification();
      item.id = 0;
      item.action = RecipeManagementAction.add;
      item.item = Recipe();
      lst.add(item);
      //act
      controller.modifyLstStorageItemDisplayed(lst);

      //assert
      expect(controller.lstRecipe.length, 1);
    });
  });
}
