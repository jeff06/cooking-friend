import 'package:cooking_friend/features/recipe/business/entities/recipe_ingredient_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';
import 'package:cooking_friend/features/storage/presentation/widgets/import_recipe_popup.dart';
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
    //L'erreur vient peut-être de resetController()
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
      bool isFavorite, List<int> ingredientsToRemove, List<int> stepsToRemove) async {
    return await _save(formKey, context, lstRecipeModification, isFavorite, ingredientsToRemove, stepsToRemove)
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
    await recipeRepository.deleteRecipe(id: recipeGetx.currentId!).then(
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
      GlobalKey<FormBuilderState> formKey, List<int> ingredientsToRemove, List<int> stepsToRemove) async {
    if (recipeGetx.action == RecipeManagementAction.edit.name.obs) {
      await recipeRepository
          .updateRecipe(
        recipe: recipe.toModel(), ingredientsToRemove: ingredientsToRemove, stepsToRemove :stepsToRemove
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
      bool isFavorite, List<int> ingredientsToRemove, List<int> stepsToRemove) async {
    // ne pas saver ce qui ont le meme id
    if (formKey.currentState!.saveAndValidate()) {
      List<RecipeStepEntity> steps = [];
      List<RecipeIngredientEntity> ingredients = [];
      for (int i = 0; i < recipeGetx.steps.length; i++) {
        var currentElement = recipeGetx.steps[i];
        var content = formKey.currentState?.value["rs_${currentElement.guid}"];
        RecipeStepEntity step =
            RecipeStepEntity(currentElement.step?.idStep, recipeGetx.currentId, content, i);

        steps.add(step);
      }

      for (int i = 0; i < recipeGetx.ingredients.length; i++) {
        var currentElement = recipeGetx.ingredients[i];
        RecipeIngredientEntity ri = RecipeIngredientEntity(
            currentElement.ingredient?.idIngredient,
            recipeGetx.currentId,
            formKey.currentState?.value["ri_${currentElement.guid}"],
            formKey.currentState?.value["riu_${currentElement.guid}"],
            double.tryParse(
                formKey.currentState?.value["riq_${currentElement.guid}"]),
            i);

        ingredients.add(ri);
      }

      RecipeEntity newRecipe = RecipeEntity(
          recipeGetx.currentId,
          formKey.currentState?.value["recipe_title"],
          isFavorite ? 1 : 0,
          steps,
          ingredients);

      await _saveAndUpdate(newRecipe, lstRecipeModification, formKey, ingredientsToRemove, stepsToRemove)
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

  Future<String?> requestUrlToImport(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const ImportRecipePopup();
      },
    );
  }
}
