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
    var listReturned = await Navigator.pushNamed(context, path);
    controller.modifyLstStorageItemDisplayed(
        listReturned as List<RecipeModification>);
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
        Navigator.pop(context, lstStorageItemModification);
      },
    );
  }

  Future<void> _saveAndUpdate(
      Recipe recipe,
      List<RecipeModification> lstRecipeModification,
      BuildContext context,
      GlobalKey<FormBuilderState> formKey) async {
    if (controller.action == RecipeManagementAction.edit.name.obs) {
      await isarService.updateRecipe(recipe, controller.currentId).then((res) {
        lstRecipeModification.add(RecipeModification()
          ..id = controller.currentId
          ..action = RecipeManagementAction.edit
          ..item = recipe);
        Navigator.pop(context, lstRecipeModification);
      });
    } else {
      await isarService.saveNewRecipe(recipe).then((res) {
        recipe.id = res;
        lstRecipeModification.add(RecipeModification()
          ..id = res
          ..action = RecipeManagementAction.add
          ..item = recipe);
        formKey.currentState!.reset();
      });
    }
  }

  save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<RecipeModification> lstRecipeModification) async {
    // ne pas saver ce qui ont le meme id
    if (formKey.currentState!.saveAndValidate()) {
      Recipe newRecipe = Recipe()
        ..name = formKey.currentState?.value["recipe_title"];
      for (var v in controller.steps) {
        var content = formKey.currentState?.value["rs_${v.guid}"];
        RecipeStep step = RecipeStep()..step = content;
        if (v.step != null) {
          step.id = v.step!.id;
        }
        newRecipe.lstSteps.add(step);
      }

      for (var v in controller.ingredients) {
        RecipeIngredient ri = RecipeIngredient();
        ri.ingredient = formKey.currentState?.value["ri_${v.guid}"];
        ri.measuringUnit = formKey.currentState?.value["riu_${v.guid}"];
        ri.quantity = float.parse(formKey.currentState?.value["riq_${v.guid}"]);
        if (v.ingredient != null) {
          ri.id = v.ingredient!.id;
        }
        newRecipe.lstIngredients.add(ri);
      }

      await _saveAndUpdate(newRecipe, lstRecipeModification, context, formKey)
          .then((res) {
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
