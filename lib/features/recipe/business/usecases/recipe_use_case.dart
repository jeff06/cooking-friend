import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_modification_entity.dart';
import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RecipeUseCase {
  final RecipeGetx recipeGetx;
  final IRecipeRepositoryImplementation recipeRepository;

  RecipeUseCase(this.recipeGetx, this.recipeRepository);

  Future<void> updateList(String path, BuildContext context) async {
    await Navigator.pushNamed(context, path);
    recipeGetx.modifyLstStorageItemDisplayed();
    recipeGetx.resetController();
  }

  Future<void> delete(BuildContext context,
      List<RecipeModificationEntity> lstRecipeModification) async {
    await _delete(lstRecipeModification, context).then((res) {
      recipeGetx.updateLstRecipeModification(lstRecipeModification);
      if (!context.mounted) return;
      Navigator.of(context).pop();
    });
  }

  void edit() async {
    if (recipeGetx.action == RecipeManagementAction.view.name.obs) {
      recipeGetx.updateAction(RecipeManagementAction.edit);
    } else {
      recipeGetx.updateAction(RecipeManagementAction.view);
    }
  }

  Future<bool> save(
      GlobalKey<FormBuilderState> formKey,
      BuildContext context,
      List<RecipeModificationEntity> lstRecipeModification,
      bool isFavorite) async {
    return await _save(formKey, context, lstRecipeModification, isFavorite)
        .then((success) {
      if (success) {
        recipeGetx.updateLstRecipeModification(lstRecipeModification);
      }
      return success;
    });
  }

  Future<void> clickOnCard(int id, BuildContext context) async {
    recipeGetx.updateSelectedId(id);
    recipeGetx.updateAction(RecipeManagementAction.view);
    await updateList("/recipeManagement", context);
  }

  Future<void> _delete(
      List<RecipeModificationEntity> lstStorageItemModification,
      BuildContext context) async {
    await recipeRepository.deleteRecipe(id: recipeGetx.currentId).then(
      (res) {
        lstStorageItemModification.add(RecipeModificationEntity()
          ..id = recipeGetx.currentId
          ..action = RecipeManagementAction.delete
          ..item = null);
      },
    );
  }

  Future<void> _saveAndUpdate(
      RecipeEntity recipe,
      List<RecipeModificationEntity> lstRecipeModification,
      GlobalKey<FormBuilderState> formKey) async {
    if (recipeGetx.action == RecipeManagementAction.edit.name.obs) {
      await recipeRepository
          .updateRecipe(
        recipe: recipe.toModel(),
      )
          .then((res) {
        lstRecipeModification.add(RecipeModificationEntity()
          ..id = recipeGetx.currentId
          ..action = RecipeManagementAction.edit
          ..item = recipe.toModel());
      });
    } else {
      await recipeRepository
          .saveNewRecipe(recipe: recipe.toModel())
          .then((either) {
        either.fold((failure) {}, (newId) {
          lstRecipeModification.add(RecipeModificationEntity()
            ..id = newId
            ..action = RecipeManagementAction.add
            ..item = recipe.toModel(newId));
        });
      });
    }
    formKey.currentState!.reset();
  }

  Future<bool> _save(
      GlobalKey<FormBuilderState> formKey,
      BuildContext context,
      List<RecipeModificationEntity> lstRecipeModification,
      bool isFavorite) async {
    // ne pas saver ce qui ont le meme id
    if (formKey.currentState!.saveAndValidate()) {
      RecipeEntity newRecipe = RecipeEntity(null, formKey.currentState?.value["recipe_title"], isFavorite);
      /*for (int i = 0; i < recipeGetx.steps.length; i++) {
        var currentElement = recipeGetx.steps[i];
        var content = formKey.currentState?.value["rs_${currentElement.guid}"];
        RecipeStepEntity step = RecipeStepEntity()..step = content;
        step.order = i;
        if (currentElement.step != null) {
          step.id = currentElement.step!.id;
        }

        newRecipe.lstSteps.add(step);
      }*/

      /*for (int i = 0; i < recipeGetx.ingredients.length; i++) {
        var currentElement = recipeGetx.ingredients[i];
        RecipeIngredientEntity ri = RecipeIngredientEntity();
        ri.ingredient =
            formKey.currentState?.value["ri_${currentElement.guid}"];
        ri.measuringUnit =
            formKey.currentState?.value["riu_${currentElement.guid}"];
        ri.quantity = double.parse(
            formKey.currentState?.value["riq_${currentElement.guid}"]);
        if (currentElement.ingredient != null) {
          ri.id = currentElement.ingredient!.id;
        }
        ri.order = i;
        newRecipe.lstIngredients.add(ri);
      }*/

      await _saveAndUpdate(newRecipe, lstRecipeModification, formKey)
          .then((res) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(recipeGetx.action.string == "add"
                ? "New recipe added"
                : "Recipe edited"),
          ),
        );
        recipeGetx.resetController();
      });
      return true;
    }
    return false;
  }
}
