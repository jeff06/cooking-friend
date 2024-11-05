import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';
import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_modification_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('modifyLstStorageItemDisplayed', () {
    test('Do nothing', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeModificationEntity> lst = [];
      controller.updateLstRecipeModification(lst);
      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe.length, 0);
    });
    test('Add one', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeModificationEntity> lst = [];
      RecipeModificationEntity item = RecipeModificationEntity();
      item.id = 0;
      item.action = RecipeManagementAction.add;
      item.item = RecipeEntity(null, null, null, null, null);
      lst.add(item);
      controller.updateLstRecipeModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe.length, 1);
    });
    test('Remove one', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeModificationEntity> lst = [];
      RecipeEntity recipeToRemove = RecipeEntity(0, null, null, null, null);
      controller.lstRecipe.add(recipeToRemove);
      RecipeModificationEntity item = RecipeModificationEntity();
      item.id = 0;
      item.action = RecipeManagementAction.delete;
      item.item = RecipeEntity(0, null, null, null, null);
      lst.add(item);
      controller.updateLstRecipeModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe.length, 0);
    });
    test('Edit one', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeModificationEntity> lst = [];
      RecipeEntity recipeToEdit =
          RecipeEntity(0, "recipe name", null, null, null);
      controller.lstRecipe.add(recipeToEdit);
      RecipeModificationEntity item = RecipeModificationEntity();
      item.id = 0;
      item.action = RecipeManagementAction.edit;
      item.item = RecipeEntity(0, "modified name", null, null, null);
      lst.add(item);
      controller.updateLstRecipeModification(lst);

      //act
      controller.modifyLstStorageItemDisplayed();

      //assert
      expect(controller.lstRecipe[0].title, "modified name");
    });
  });
  group('updateLstRecipeDisplayed', () {
    test('Do nothing', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeEntity> lst = [];
      //act
      controller.updateLstRecipeDisplayed(lst);

      //assert
      expect(controller.lstRecipe.length, 0);
    });
    test('Add one', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeEntity> lst = [];
      RecipeEntity entity = RecipeEntity(0, 'Mock', 0, [], []);
      lst.add(entity);
      //act
      controller.updateLstRecipeDisplayed(lst);

      //assert
      expect(controller.lstRecipe.length, 1);
    });
  });
  group('updateLstRecipeStepsDisplayed', () {
    test('Update steps displayed', () {
      //arrange
      RecipeGetx controller = RecipeGetx();
      List<RecipeStepEntity> newRecipeSteps = [];
      newRecipeSteps.add(RecipeStepEntity(0, 0, '', 3));
      newRecipeSteps.add(RecipeStepEntity(0, 0, '', 0));
      newRecipeSteps.add(RecipeStepEntity(0, 0, '', 1));
      newRecipeSteps.add(RecipeStepEntity(0, 0, '', 2));

      //act
      controller.updateLstRecipeStepsDisplayed(newRecipeSteps);

      //assert
      expect(controller.steps.length, 0);
      expect(controller.steps.last.step!.ordering, 3);
    });
  });
  group('updateFavorite', () {});
}
