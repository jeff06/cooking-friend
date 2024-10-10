import 'dart:convert';

import 'package:cooking_friend/features/recipe/business/entities/imported_recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_ingredient_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';
import 'package:cooking_friend/features/recipe/presentation/widgets/recipe_ingredient.dart';
import 'package:cooking_friend/features/recipe/presentation/widgets/recipe_step.dart';
import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_modification_entity.dart';
import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      bool isFavorite,
      List<int> ingredientsToRemove,
      List<int> stepsToRemove) async {
    return await _save(formKey, context, lstRecipeModification, isFavorite,
            ingredientsToRemove, stepsToRemove)
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

  void updateFilterRules(String orderBy, String direction) {
    recipeGetx.currentDirection =
        OrderByDirection.values.firstWhere((x) => x.paramName == direction);

    recipeGetx.currentOrderBy =
        RecipeOrderBy.values.firstWhere((x) => x.paramName == orderBy);
  }

  Future<void> orderBy(List<RecipeEntity> lstRecipe) async {
    switch (recipeGetx.currentOrderBy) {
      case RecipeOrderBy.id:
        if (recipeGetx.currentDirection == OrderByDirection.ascending) {
          lstRecipe.sort((a, b) => a.idRecipe!.compareTo(b.idRecipe!));
        } else {
          lstRecipe.sort((a, b) => b.idRecipe!.compareTo(a.idRecipe!));
        }
      case RecipeOrderBy.name:
        if (recipeGetx.currentDirection == OrderByDirection.ascending) {
          lstRecipe.sort((a, b) => a.title!.compareTo(b.title!));
        } else {
          lstRecipe.sort((a, b) => b.title!.compareTo(a.title!));
        }
      case RecipeOrderBy.favorite:
        if (recipeGetx.currentDirection == OrderByDirection.ascending) {
          lstRecipe.sort(
            (a, b) {
              return b.isFavorite != null && b.isFavorite! == 1 ? 1 : 0;
            },
          );
        } else {
          lstRecipe.sort(
            (a, b) {
              return a.isFavorite != null && a.isFavorite! == 1 ? 1 : 0;
            },
          );
        }
    }
  }

  Future<String?> requestUrlToImport(BuildContext context) async {
    final GlobalKey<FormBuilderState> filterMenuKey =
        GlobalKey<FormBuilderState>();
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FormBuilder(
                  key: filterMenuKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          decoration: const InputDecoration(
                            labelText: "URL",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          name: "url",
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text('Accept'),
                      onPressed: () {
                        filterMenuKey.currentState!.saveAndValidate();
                        String url = filterMenuKey.currentState?.value["url"];
                        Navigator.of(context).pop(url);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void processImportedRecipe(http.Response response, TextEditingController recipeTitleController) {
    ImportedRecipeEntity importedRecipe =
        ImportedRecipeEntity.fromJson(json.decode(response.body));
    recipeTitleController.text = importedRecipe.name!;
    recipeGetx.ingredients.removeWhere((x) => true);

    for (var v in importedRecipe.ingredients!) {
      RecipeIngredientEntity recipeIngredient =
          RecipeIngredientEntity(null, null, v.name, null, null, null);
      recipeIngredient.ingredient = v.name;
      recipeGetx.ingredients.add(RecipeIngredient(recipeIngredient));
    }

    var steps = importedRecipe.instructions?.first.steps;
    if (steps != null) {
      recipeGetx.steps.removeWhere((x) => true);
      for (var v in steps) {
        RecipeStepEntity recipeStep =
            RecipeStepEntity(null, null, v.text, null);
        TextEditingController textEditingController = TextEditingController();
        textEditingController.text = v.text!;
        recipeGetx.steps.add(RecipeStep(textEditingController, recipeStep));
      }
    }
  }

  Future<SpeedDial> availableFloatingAction(
      BuildContext context,
      GlobalKey<FormBuilderState> formKey,
      List<RecipeModificationEntity> lstRecipeModification,
      TextEditingController recipeTitleController,
      Future<void> importRecipeFromUrl) async {
    List<SpeedDialChild> lst = [];
    if (recipeGetx.action == RecipeManagementAction.edit.name.obs ||
        recipeGetx.action == RecipeManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          onTap: () async {
            await save(
                    formKey,
                    context,
                    lstRecipeModification,
                    recipeGetx.currentFavorite.value,
                    recipeGetx.ingredientsToRemove,
                    recipeGetx.stepsToRemove)
                .then((success) {
              if (success) {
                recipeTitleController.text = "";
                recipeGetx.updateFavorite(false);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              }
            });
          },
        ),
      );
    }

    if (recipeGetx.action == RecipeManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
            child: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            backgroundColor: Colors.pinkAccent,
            onTap: () async => importRecipeFromUrl),
      );
    }

    if (recipeGetx.action != RecipeManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: Icon(
            recipeGetx.action == RecipeManagementAction.view.name.obs
                ? Icons.edit
                : Icons.edit_outlined,
            color: Colors.white,
          ),
          backgroundColor: CustomTheme.navbar,
          onTap: () async {
            edit();
          },
        ),
      );
    }

    if (recipeGetx.action == RecipeManagementAction.edit.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onTap: () async {
            await delete(context, lstRecipeModification);
          },
        ),
      );
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: lst,
    );
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
      GlobalKey<FormBuilderState> formKey,
      List<int> ingredientsToRemove,
      List<int> stepsToRemove) async {
    if (recipeGetx.action == RecipeManagementAction.edit.name.obs) {
      await recipeRepository
          .updateRecipe(
              recipe: recipe.toModel(),
              ingredientsToRemove: ingredientsToRemove,
              stepsToRemove: stepsToRemove)
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
      bool isFavorite,
      List<int> ingredientsToRemove,
      List<int> stepsToRemove) async {
    // ne pas saver ce qui ont le meme id
    if (formKey.currentState!.saveAndValidate()) {
      List<RecipeStepEntity> steps = [];
      List<RecipeIngredientEntity> ingredients = [];
      for (int i = 0; i < recipeGetx.steps.length; i++) {
        var currentElement = recipeGetx.steps[i];
        var content = formKey.currentState?.value["rs_${currentElement.guid}"];
        RecipeStepEntity step = RecipeStepEntity(
            currentElement.step?.idStep, recipeGetx.currentId, content, i);

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

      await _saveAndUpdate(newRecipe, lstRecipeModification, formKey,
              ingredientsToRemove, stepsToRemove)
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
