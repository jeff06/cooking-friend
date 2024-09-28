import 'dart:async';
import 'dart:convert';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/imported_recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/screens/recipe/widget/recipe_ingredient.dart'
    as ri_widget;
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart'
    as ri_model;
import 'package:cooking_friend/screens/recipe/widget/recipe_step.dart'
    as rs_widget;
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart' as rs_model;
import 'package:cooking_friend/getx/models/recipe/recipe_modification.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/getx/services/recipe_service.dart';
import 'package:cooking_friend/screens/support/gradient_background.dart';
import 'package:cooking_friend/screens/support/loading.dart';
import 'package:cooking_friend/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class RecipeManagement extends StatefulWidget {
  final IsarService service;

  const RecipeManagement(this.service, {super.key});

  @override
  State<RecipeManagement> createState() => _RecipeManagementState();
}

class _RecipeManagementState extends State<RecipeManagement> {
  final _formKey = GlobalKey<FormBuilderState>();
  final RecipeController recipeController = Get.find<RecipeController>();
  final TextEditingController _recipeTitleController = TextEditingController();
  late final RecipeService _recipeService =
      RecipeService(recipeController, widget.service);
  Future<Recipe?> recipeToDisplay = Completer<Recipe?>().future;
  List<RecipeModification> lstRecipeModification = [];
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (recipeController.action == RecipeManagementAction.view.name.obs) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          recipeToDisplay =
              widget.service.getSingleRecipe(recipeController.currentId);
        });
      });
    }
  }

  Future<SpeedDial> availableFloatingAction(BuildContext context) async {
    List<SpeedDialChild> lst = [];
    if (recipeController.action == RecipeManagementAction.edit.name.obs ||
        recipeController.action == RecipeManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          onTap: () async {
            await _recipeService
                .save(_formKey, context, lstRecipeModification,
                    recipeController.currentFavorite.value)
                .then((success) {
              if (success) {
                _recipeTitleController.text = "";
                recipeController.updateFavorite(false);
                if (!context.mounted) return;
                Navigator.of(context).pop();
              }
            });
          },
        ),
      );
    }

    if (recipeController.action == RecipeManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.download,
            color: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          onTap: () async {
            String recipeUrl =
                "https://www.ricardocuisine.com/en/recipes/6392-basic-risotto";
            String urlToCall =
                'https://www.justtherecipe.com/extractRecipeAtUrl?url=$recipeUrl';
            var response = await http.get(Uri.parse(urlToCall));
            if (response.statusCode == 200) {
              ImportedRecipe importedRecipe =
                  ImportedRecipe.fromJson(json.decode(response.body));
              _recipeTitleController.text = importedRecipe.name!;
              recipeController.ingredients.removeWhere((x) => true);
              for (var v in importedRecipe.ingredients!) {
                ri_model.RecipeIngredient recipeIngredient =
                    ri_model.RecipeIngredient();
                recipeIngredient.ingredient = v.name;
                recipeController.ingredients
                    .add(ri_widget.RecipeIngredient(recipeIngredient));
              }

              var steps = importedRecipe.instructions?.first.steps;
              if (steps != null) {
                recipeController.steps.removeWhere((x) => true);
                for (var v in steps) {
                  rs_model.RecipeStep recipeStep = rs_model.RecipeStep();
                  recipeStep.step = v.text;
                  TextEditingController textEditingController =
                      TextEditingController();
                  textEditingController.text = v.text!;
                  recipeController.steps.add(
                      rs_widget.RecipeStep(textEditingController, recipeStep));
                }
              }

              print(importedRecipe.name);
            }
          },
        ),
      );
    }

    if (recipeController.action != RecipeManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: Icon(
            recipeController.action == RecipeManagementAction.view.name.obs
                ? Icons.edit
                : Icons.edit_outlined,
            color: Colors.white,
          ),
          backgroundColor: CustomTheme.navbar,
          onTap: () async {
            _recipeService.edit();
          },
        ),
      );
    }

    if (recipeController.action == RecipeManagementAction.edit.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onTap: () async {
            await _recipeService.delete(context, lstRecipeModification);
          },
        ),
      );
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: lst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      Scaffold(
        floatingActionButton: Obx(
          () => FutureBuilder<SpeedDial>(
            future: availableFloatingAction(context),
            builder: (builder, AsyncSnapshot<SpeedDial> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data as SpeedDial;
              }
              return const SpeedDial();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Recipe?>(
            future: recipeToDisplay,
            builder: (BuildContext context, AsyncSnapshot<Recipe?> snapshot) {
              if (snapshot.hasData ||
                  recipeController.action ==
                      RecipeManagementAction.add.name.obs) {
                if (recipeController.action ==
                        RecipeManagementAction.view.name.obs ||
                    recipeController.action ==
                        RecipeManagementAction.edit.name.obs) {
                  _recipeTitleController.text =
                      (snapshot.data != null ? snapshot.data?.name : "")!;

                  recipeController.updateLstRecipeStepsDisplayed(
                      snapshot.data!.steps.toList());

                  recipeController.updateLstRecipeIngredientsDisplayed(
                      snapshot.data!.ingredients.toList());

                  recipeController.updateFavorite(snapshot.data!.isFavorite!);
                }
                return Obx(
                  () => SingleChildScrollView(
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                onPressed: recipeController.action ==
                                        StorageManagementAction.view.name.obs
                                    ? null
                                    : () {
                                        recipeController.updateFavorite(
                                            !recipeController
                                                .currentFavorite.value);
                                      },
                                icon: Icon(
                                  recipeController.currentFavorite.value
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.red,
                                ),
                              ),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: "recipe_title",
                                  decoration: const InputDecoration(
                                    labelText: "Title",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  controller: _recipeTitleController,
                                  enabled: recipeController.action ==
                                          StorageManagementAction.view.name.obs
                                      ? false
                                      : true,
                                  validator: FormBuilderValidators.compose(
                                    [
                                      FormBuilderValidators.required(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Container(
                              child: recipeController.steps.isEmpty
                                  ? IconButton(
                                      onPressed: () => recipeController
                                          .addEmptyStep(const Uuid().v4()),
                                      icon: const Icon(Icons.add))
                                  : ReorderableListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      header: const Text("Steps"),
                                      shrinkWrap: true,
                                      onReorder: (int oldIndex, int newIndex) {
                                        if (newIndex > oldIndex) newIndex--;
                                        final step = recipeController.steps
                                            .removeAt(oldIndex);
                                        recipeController.steps
                                            .insert(newIndex, step);
                                      },
                                      itemCount: recipeController.steps.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var element =
                                            recipeController.steps[index];
                                        return Container(
                                            key: ValueKey(element),
                                            child: element);
                                      },
                                    ),
                            ),
                          ),
                          Obx(
                            () => Container(
                              child: recipeController.ingredients.isEmpty
                                  ? IconButton(
                                      onPressed: () =>
                                          recipeController.addEmptyIngredient(
                                              const Uuid().v4()),
                                      icon: const Icon(Icons.add))
                                  : ReorderableListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      header: const Text("Ingredients"),
                                      shrinkWrap: true,
                                      onReorder: (int oldIndex, int newIndex) {
                                        if (newIndex > oldIndex) newIndex--;
                                        
                                        final ingredient = recipeController
                                            .ingredients
                                            .removeAt(oldIndex);
                                        recipeController.ingredients
                                            .insert(newIndex, ingredient);
                                      },
                                      itemCount:
                                          recipeController.ingredients.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var element =
                                            recipeController.ingredients[index];
                                        return Container(
                                            key: ValueKey(element),
                                            child: element);
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Loading();
              }
            },
          ),
        ),
      ),
    );
  }
}
