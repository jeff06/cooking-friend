import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_modification.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/getx/services/recipe_service.dart';
import 'package:cooking_friend/screens/support/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

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
  late final RecipeService _storageService =
      RecipeService(recipeController, widget.service);
  Future<Recipe?> recipeToDisplay = Completer<Recipe?>().future;
  List<RecipeModification> lstRecipeModification = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, lstRecipeModification);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: recipeController.action != RecipeManagementAction.add.name.obs
            ? <Widget>[
                Obx(
                  () => IconButton(
                    icon: Icon(
                      recipeController.action ==
                              RecipeManagementAction.view.name.obs
                          ? Icons.edit
                          : Icons.edit_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (recipeController.action ==
                          RecipeManagementAction.view.name.obs) {
                        recipeController
                            .updateAction(RecipeManagementAction.edit);
                      } else {
                        recipeController
                            .updateAction(RecipeManagementAction.view);
                      }
                    },
                  ),
                )
              ]
            : [],
        title: const Text("add recipe"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _storageService.save(_formKey, context, lstRecipeModification);
        },
        child: const Icon(Icons.save),
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
                  RecipeManagementAction.view.name.obs || recipeController.action ==
                  RecipeManagementAction.edit.name.obs) {
                _recipeTitleController.text =
                    (snapshot.data != null ? snapshot.data?.name : "")!;
                recipeController.updateLstRecipeStepsDisplayed(
                    snapshot.data!.steps.toList());
                recipeController.updateLstRecipeIngredientsDisplayed(
                    snapshot.data!.ingredients.toList());
              }
              return Obx(
                () => FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: "recipe_title",
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
                      const Text("Steps"),
                      Expanded(
                        child: Obx(
                          () => ReorderableListView.builder(
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) newIndex--;
                              final step =
                                  recipeController.steps.removeAt(oldIndex);
                              recipeController.steps.insert(newIndex, step);
                            },
                            itemCount: recipeController.steps.length,
                            itemBuilder: (BuildContext context, int index) {
                              var element = recipeController.steps[index];
                              return Container(
                                  key: ValueKey(element), child: element);
                            },
                          ),
                        ),
                      ),
                      const Text("Ingredients"),
                      Expanded(
                        child: Obx(
                          () => ReorderableListView.builder(
                            onReorder: (int oldIndex, int newIndex) {
                              if (newIndex > oldIndex) newIndex--;
                              final step = recipeController.ingredients
                                  .removeAt(oldIndex);
                              recipeController.ingredients
                                  .insert(newIndex, step);
                            },
                            itemCount: recipeController.ingredients.length,
                            itemBuilder: (BuildContext context, int index) {
                              var element = recipeController.ingredients[index];
                              return Container(
                                  key: ValueKey(element), child: element);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Loading();
            }
          },
        ),
      ),
    );
  }
}
