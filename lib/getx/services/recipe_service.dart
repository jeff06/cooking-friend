import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_modification.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class RecipeService {
  final RecipeController controller;
  final IsarService isarService;

  RecipeService(this.controller, this.isarService);

  Future<void> updateList(String path, BuildContext context) async {
    await Navigator.pushNamed(context, path);
    controller.modifyLstStorageItemDisplayed(controller.lstRecipeModification);
    controller.resetController();
  }

  Future<void> delete(List<RecipeModification> lstStorageItemModification,
      BuildContext context) async {
    await isarService.deleteRecipe(controller.currentId).then(
      (res) {
        lstStorageItemModification.add(RecipeModification()
          ..id = controller.currentId
          ..action = RecipeManagementAction.delete
          ..item = null);
      },
    );
  }

  Future<void> _saveAndUpdate(
      Recipe recipe,
      List<RecipeModification> lstRecipeModification,
      BuildContext context,
      GlobalKey<FormBuilderState> formKey) async {
    if (controller.action == RecipeManagementAction.edit.name.obs) {
      await isarService.updateRecipe(recipe, controller.currentId, controller.ingredientsToRemove, controller.stepsToRemove).then((res) {
        lstRecipeModification.add(RecipeModification()
          ..id = controller.currentId
          ..action = RecipeManagementAction.edit
          ..item = recipe);
        if (!context.mounted) return;
        Navigator.pop(context);
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

  Future<void> save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<RecipeModification> lstRecipeModification) async {
    // ne pas saver ce qui ont le meme id
    if (formKey.currentState!.saveAndValidate()) {
      Recipe newRecipe = Recipe()
        ..name = formKey.currentState?.value["recipe_title"];
      for (int i =0; i < controller.steps.length; i++) {
        var currentElement = controller.steps[i];
        var content = formKey.currentState?.value["rs_${currentElement.guid}"];
        RecipeStep step = RecipeStep()..step = content;
        step.order = i;
        if (currentElement.step != null) {
          step.id = currentElement.step!.id;
        }

        newRecipe.lstSteps.add(step);
      }

      for (int i = 0; i < controller.ingredients.length; i++) {
        var currentElement = controller.ingredients[i];
        RecipeIngredient ri = RecipeIngredient();
        ri.ingredient = formKey.currentState?.value["ri_${currentElement.guid}"];
        ri.measuringUnit = formKey.currentState?.value["riu_${currentElement.guid}"];
        ri.quantity = float.parse(formKey.currentState?.value["riq_${currentElement.guid}"]);
        if (currentElement.ingredient != null) {
          ri.id = currentElement.ingredient!.id;
        }
        ri.order = i;
        newRecipe.lstIngredients.add(ri);
      }

      await _saveAndUpdate(newRecipe, lstRecipeModification, context, formKey)
          .then((res) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Recipe added"),
          ),
        );
        controller.resetController();
      });
    }
  }
}
