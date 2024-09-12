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
      controller.updateLstRecipeModification(lst);
      //act
      controller.modifyLstStorageItemDisplayed();

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
      controller.updateLstRecipeModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe.length, 1);
    });

    test('Remove one', (){
      //arrange
      RecipeController controller = RecipeController();
      List<RecipeModification> lst = [];
      Recipe recipeToRemove = Recipe();
      recipeToRemove.id = 0;
      controller.lstRecipe.add(recipeToRemove);
      RecipeModification item = RecipeModification();
      item.id = 0;
      item.action = RecipeManagementAction.delete;
      item.item = Recipe();
      lst.add(item);
      controller.updateLstRecipeModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe.length, 0);
    });

    test('Edit one', (){
      //arrange
      RecipeController controller = RecipeController();
      List<RecipeModification> lst = [];
      Recipe recipeToEdit = Recipe();
      recipeToEdit.id = 0;
      recipeToEdit.name = "recipe name";
      controller.lstRecipe.add(recipeToEdit);
      RecipeModification item = RecipeModification();
      item.id = 0;
      item.action = RecipeManagementAction.edit;
      item.item = Recipe()..name = "modified name";
      lst.add(item);
      controller.updateLstRecipeModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe[0].name, "modified name");
    });
  });
}
