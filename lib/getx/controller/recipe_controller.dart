import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_modification.dart';
import 'package:cooking_friend/screens/recipe/widget/recipe_step.dart'
    as rs_widget;
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart' as rs_model;
import 'package:cooking_friend/screens/recipe/widget/recipe_ingredient.dart'
    as ri_widget;
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart'
    as ri_model;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class RecipeController extends GetxController {
  var steps = <rs_widget.RecipeStep>[rs_widget.RecipeStep(null, null)].obs;
  var ingredients =
      <ri_widget.RecipeIngredient>[ri_widget.RecipeIngredient(null)].obs;
  int currentId = -1;
  var currentFavorite = false.obs;
  var action = RecipeManagementAction.none.name.obs;
  var lstRecipe = <Recipe>[].obs;
  var lstRecipeModification = <RecipeModification>[].obs;
  List<int> ingredientsToRemove = [];
  List<int> stepsToRemove = [];
  RecipeOrderBy currentOrderBy = RecipeOrderBy.name;
  OrderByDirection currentDirection = OrderByDirection.ascending;

  void resetController() {
    steps.value = <rs_widget.RecipeStep>[rs_widget.RecipeStep(null, null)].obs;
    ingredients.value =
        <ri_widget.RecipeIngredient>[ri_widget.RecipeIngredient(null)].obs;
    currentId = -1;
    //action = RecipeManagementAction.none.name.obs;
    lstRecipeModification = <RecipeModification>[].obs;
    ingredientsToRemove = [];
    stepsToRemove = [];
    currentFavorite = false.obs;
  }

  void updateLstRecipeDisplayed(List<Recipe> newLstStorageItem) {
    lstRecipe.value = newLstStorageItem;
  }

  void updateLstRecipeStepsDisplayed(List<rs_model.RecipeStep> newRecipeSteps) {
    if (action != RecipeManagementAction.add.name.obs) {
      steps = <rs_widget.RecipeStep>[].obs;
    }
    newRecipeSteps.sort((a, b) => a.order!.compareTo(b.order!));
    for (var step in newRecipeSteps) {
      TextEditingController tec = TextEditingController();
      tec.text = step.step!;
      steps.add(rs_widget.RecipeStep(tec, step));
    }
  }

  void updateFavorite(bool newVal) {
    currentFavorite.value = newVal;
  }

  void updateLstRecipeIngredientsDisplayed(
      List<ri_model.RecipeIngredient> newRecipeIngredients) {
    if (action != RecipeManagementAction.add.name.obs) {
      ingredients = <ri_widget.RecipeIngredient>[].obs;
    }
    newRecipeIngredients.sort((a, b) => a.order!.compareTo(b.order!));
    for (var ingredient in newRecipeIngredients) {
      ingredients.add(ri_widget.RecipeIngredient(ingredient));
    }
  }

  void modifyLstStorageItemDisplayed() {
    for (var v in lstRecipeModification) {
      switch (v.action) {
        case RecipeManagementAction.add:
          lstRecipe.add(v.item!);
          break;
        case RecipeManagementAction.view:
          break;
        case RecipeManagementAction.edit:
          lstRecipe[lstRecipe.indexWhere((x) => x.id == v.id)] = v.item!;
          break;
        case RecipeManagementAction.none:
          break;
        case RecipeManagementAction.delete:
          lstRecipe.removeWhere((x) => x.id == v.id);
          break;
        case null:
          break;
      }
    }
  }

  void updateSelectedId(int selectedId) async {
    currentId = selectedId;
  }

  void updateAction(RecipeManagementAction newAction) async {
    action.value = newAction.name;
  }

  void addEmptyStep(String guid) {
    int indexToInsert = steps.indexWhere((x) => x.guid == guid);
    steps.insert(indexToInsert + 1, rs_widget.RecipeStep(null, null));
  }

  void removeStep(String guid, [int? id]) {
    steps.removeWhere((x) => x.guid == guid);
    if (id != null) {
      stepsToRemove.add(id);
    }
  }

  void addEmptyIngredient(String guid) {
    int indexToInsert = ingredients.indexWhere((x) => x.guid == guid);
    ingredients.insert(indexToInsert + 1, ri_widget.RecipeIngredient(null));
  }

  void removeIngredient(String guid, [Id? id]) {
    ingredients.removeWhere((x) => x.guid == guid);
    if (id != null) {
      ingredientsToRemove.add(id);
    }
  }

  void updateLstRecipeModification(List<RecipeModification> lst) {
    lstRecipeModification.value = lst;
  }
}
