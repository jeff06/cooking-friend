import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_model.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/getx/services/recipe_service.dart';
import 'package:cooking_friend/screens/support/gradient_background.dart';
import 'package:cooking_friend/screens/support/search_bar_custom.dart';
import 'package:cooking_friend/screens/support/search_display_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeView extends StatefulWidget {
  final IsarService service;

  const RecipeView(this.service, {super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final TextEditingController searchBarController = TextEditingController();
  final RecipeController recipeController = Get.find<RecipeController>();
  Future<List<Recipe>> recipeToDisplay = Completer<List<Recipe>>().future;
  late final RecipeService recipeService =
      RecipeService(recipeController, widget.service);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await refreshList();
    });
  }

  Future<void> refreshList() async {
    setState(() {
      recipeToDisplay =
          widget.service.getAllRecipeByFilter(searchBarController.text);
    });
  }

  void updateFilterRules(String orderBy, String direction) {
    recipeController.currentDirection =
        OrderByDirection.values.firstWhere((x) => x.paramName == direction);

    recipeController.currentOrderBy =
        RecipeOrderBy.values.firstWhere((x) => x.paramName == orderBy);
  }

  Future<void> orderBy(List<Recipe> lstRecipe) async {
    switch (recipeController.currentOrderBy) {
      case RecipeOrderBy.id:
        if (recipeController.currentDirection == OrderByDirection.ascending) {
          lstRecipe.sort((a, b) => a.id.compareTo(b.id));
        } else {
          lstRecipe.sort((a, b) => b.id.compareTo(a.id));
        }
      case RecipeOrderBy.name:
        if (recipeController.currentDirection == OrderByDirection.ascending) {
          lstRecipe.sort((a, b) => a.name!.compareTo(b.name!));
        } else {
          lstRecipe.sort((a, b) => b.name!.compareTo(a.name!));
        }
      case RecipeOrderBy.favorite:
        if (recipeController.currentDirection == OrderByDirection.ascending) {
          lstRecipe.sort(
            (a, b) {
              return b.isFavorite != null && b.isFavorite! ? 1 : 0;
            },
          );
        } else {
          lstRecipe.sort(
            (a, b) {
              return a.isFavorite != null && a.isFavorite! ? 1 : 0;
            },
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    double tenP = (screenWidth * 0.10).floorToDouble();
    return GradientBackground(
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            recipeController.updateAction(RecipeManagementAction.add);
            await recipeService.updateList("/recipeAdd", context);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBarCustom(
                searchBarController,
                refreshList,
                updateFilterRules,
                null,
                RecipeOrderBy.values.map((toElement) {
                  return toElement.paramName;
                }).toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(tenP, 0, tenP, 10),
                child: FutureBuilder<List<Recipe>>(
                  future: recipeToDisplay,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      recipeController.updateLstRecipeDisplayed(snapshot.data!);
                      return RefreshIndicator(
                        onRefresh: () => refreshList(),
                        child: Obx(() {
                          orderBy(snapshot.data!);
                          return ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: recipeController.lstRecipe.length,
                            itemBuilder: (BuildContext context, int index) {
                              String name =
                                  recipeController.lstRecipe[index].name!;
                              int id = recipeController.lstRecipe[index].id;
                              return SearchDisplayCard(
                                () => recipeService.clickOnCard(id, context),
                                ListTile(
                                  leading: const Icon(Icons.album),
                                  title: Text(name),
                                ),
                              );
                            },
                          );
                        }),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
