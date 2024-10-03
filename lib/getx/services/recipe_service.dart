import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_modification.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_step_model.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class RecipeService {
  final RecipeController recipeController;
  final IsarService isarService;

  RecipeService(this.recipeController, this.isarService);

  //#region Public

  Future<void> updateList(String path, BuildContext context) async {
    await Navigator.pushNamed(context, path);
    recipeController.modifyLstStorageItemDisplayed();
    recipeController.resetController();
  }

  Future<void> delete(BuildContext context,
      List<RecipeModification> lstRecipeModification) async {
    await _delete(lstRecipeModification, context).then((res) {
      recipeController.updateLstRecipeModification(lstRecipeModification);
      if (!context.mounted) return;
      Navigator.of(context).pop();
    });
  }

  void edit() async {
    if (recipeController.action == RecipeManagementAction.view.name.obs) {
      recipeController.updateAction(RecipeManagementAction.edit);
    } else {
      recipeController.updateAction(RecipeManagementAction.view);
    }
  }

  Future<bool> save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<RecipeModification> lstRecipeModification, bool isFavorite) async {
    return await _save(formKey, context, lstRecipeModification, isFavorite)
        .then((success) {
      if (success) {
        recipeController.updateLstRecipeModification(lstRecipeModification);
      }
      return success;
    });
  }

  Future<void> clickOnCard(int id, BuildContext context) async {
    recipeController.updateSelectedId(id);
    recipeController.updateAction(RecipeManagementAction.view);
    await updateList("/recipeManagement", context);
  }

  //#endregion

  //#region Private

  Future<void> _delete(List<RecipeModification> lstStorageItemModification,
      BuildContext context) async {
    await isarService.deleteRecipe(recipeController.currentId).then(
      (res) {
        lstStorageItemModification.add(RecipeModification()
          ..id = recipeController.currentId
          ..action = RecipeManagementAction.delete
          ..item = null);
      },
    );
  }

  Future<void> _saveAndUpdate(
      RecipeModel recipe,
      List<RecipeModification> lstRecipeModification,
      GlobalKey<FormBuilderState> formKey) async {
    if (recipeController.action == RecipeManagementAction.edit.name.obs) {
      await isarService
          .updateRecipe(
              recipe,
              recipeController.currentId,
              recipeController.ingredientsToRemove,
              recipeController.stepsToRemove)
          .then((res) {
        lstRecipeModification.add(RecipeModification()
          ..id = recipeController.currentId
          ..action = RecipeManagementAction.edit
          ..item = recipe);
      });
    } else {
      await isarService.saveNewRecipe(recipe).then((res) {
        recipe.id = res;
        lstRecipeModification.add(RecipeModification()
          ..id = res
          ..action = RecipeManagementAction.add
          ..item = recipe);
      });
    }
    formKey.currentState!.reset();
  }

  Future<bool> _save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<RecipeModification> lstRecipeModification, bool isFavorite) async {
    // ne pas saver ce qui ont le meme id
    if (formKey.currentState!.saveAndValidate()) {
      RecipeModel newRecipe = RecipeModel(null, null, null, formKey.currentState?.value["recipe_title"], isFavorite);

      for (int i = 0; i < recipeController.steps.length; i++) {
        var currentElement = recipeController.steps[i];
        var content = formKey.currentState?.value["rs_${currentElement.guid}"];
        RecipeStepModel step = RecipeStepModel()..step = content;
        step.order = i;
        if (currentElement.step != null) {
          step.id = currentElement.step!.id;
        }

        newRecipe.lstSteps.add(step);
      }

      for (int i = 0; i < recipeController.ingredients.length; i++) {
        var currentElement = recipeController.ingredients[i];
        RecipeIngredientModel ri = RecipeIngredientModel();
        ri.ingredient =
            formKey.currentState?.value["ri_${currentElement.guid}"];
        ri.measuringUnit =
            formKey.currentState?.value["riu_${currentElement.guid}"];
        ri.quantity = float
            .parse(formKey.currentState?.value["riq_${currentElement.guid}"]);
        if (currentElement.ingredient != null) {
          ri.id = currentElement.ingredient!.id;
        }
        ri.order = i;
        newRecipe.lstIngredients.add(ri);
      }

      await _saveAndUpdate(newRecipe, lstRecipeModification, formKey)
          .then((res) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(recipeController.action.string == "add"
                ? "New recipe added"
                : "Recipe edited"),
          ),
        );
        recipeController.resetController();
      });
      return true;
    }
    return false;
  }

//#endregion
}
