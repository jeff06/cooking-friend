import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RecipeService {
  final RecipeController controller;
  final IsarService isarService;

  RecipeService(this.controller, this.isarService);

  save(GlobalKey<FormBuilderState> formKey, BuildContext context) async {
    if (formKey.currentState!.saveAndValidate()) {
      Recipe newRecipe = Recipe()
        ..name = formKey.currentState?.value["recipe_title"];
      for (var v in controller.steps) {
        var content = formKey.currentState?.value["rs_${v.guid}"];
        newRecipe.steps.add(RecipeStep()..step = content);
      }

      for (var v in controller.ingredients) {
        RecipeIngredient ri = RecipeIngredient();
        ri.ingredient = formKey.currentState?.value["ri_${v.guid}"];
        ri.measuringUnit = formKey.currentState?.value["riu_${v.guid}"];
        ri.quantity = formKey.currentState?.value["riq_${v.guid}"];
        newRecipe.ingredients.add(ri);
      }

      await isarService.saveNewRecipe(newRecipe).then((res) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Recipe added"),
          ),
        );
      });
    }
  }
}