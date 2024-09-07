import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/getx/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeView extends StatefulWidget {
  final IsarService service;

  const RecipeView(this.service, {super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  String currentSearchString = "";
  final RecipeController recipeController = Get.find<RecipeController>();
  Future<List<Recipe>> recipeToDisplay = Completer<List<Recipe>>().future;
  late final RecipeService recipeService =
  RecipeService(recipeController, widget.service);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        recipeToDisplay =
            widget.service.getAllRecipeByFilter(currentSearchString);
      });
    });
  }

  Future<void> refreshList() async {
    setState(() {
      recipeToDisplay =
          widget.service.getAllRecipeByFilter(currentSearchString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .appBarTheme
            .backgroundColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              recipeController.updateAction(RecipeManagementAction.add);
              await recipeService.updateList("/recipeAdd", context);
            },
          )
        ],
        title: const Text(
          "Storage",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: FutureBuilder<List<Recipe>>(
          future: recipeToDisplay,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              snapshot.data!.sort((a, b) => b.id.compareTo(a.id));
              recipeController
                  .updateLstRecipeDisplayed(snapshot.data!);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () => refreshList(),
                  child: Obx(
                        () =>
                        ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: recipeController.lstRecipe.length,
                          itemBuilder: (BuildContext context, int index) {
                            String name = recipeController.lstRecipe[index]
                                .name!;
                            int id = recipeController.lstRecipe[index].id;
                            return Card(
                              color: Theme
                                  .of(context)
                                  .cardTheme
                                  .color,
                              child: InkWell(
                                onTap: () async {
                                  await recipeController
                                      .updateSelectedId(id)
                                      .then((res) async {
                                    await recipeController
                                        .updateAction(
                                        RecipeManagementAction.view)
                                        .then((resp) async {
                                      await recipeService.updateList(
                                          "/recipeManagement", context);
                                    });
                                  });
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(Icons.album),
                                      title: Text(name),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
