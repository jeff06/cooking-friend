import 'dart:async';

import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/repositories/recipe_repository.dart';
import 'package:cooking_friend/features/recipe/business/usecases/recipe_use_case.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/skeleton/theme/widget/gradient_background.dart';
import 'package:cooking_friend/global_widget/search_bar_custom.dart';
import 'package:cooking_friend/global_widget/search_display_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeView extends StatefulWidget {
  final IRecipeRepositoryImplementation recipeRepository;

  const RecipeView(this.recipeRepository, {super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final TextEditingController searchBarController = TextEditingController();
  final RecipeGetx recipeGetx = Get.find<RecipeGetx>();
  Future<dartz.Either<Failure, List<RecipeEntity>>> recipeToDisplay =
      Completer<dartz.Either<Failure, List<RecipeEntity>>>().future;
  late final RecipeUseCase recipeService =
      RecipeUseCase(recipeGetx, widget.recipeRepository);

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
          RecipeRepository(recipeRepository: widget.recipeRepository)
              .getAllRecipeByFilter(currentFilter: searchBarController.text);
    });
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

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    double tenP = (screenWidth * 0.10).floorToDouble();
    return GradientBackground(
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            recipeGetx.updateAction(RecipeManagementAction.add);
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
                child: FutureBuilder<dartz.Either<Failure, List<RecipeEntity>>>(
                  future: recipeToDisplay,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var widgetToDisplay = snapshot.data!.fold(
                        (failure) {
                          return const Text("FAILED");
                        },
                        (recipeEntities) {
                          recipeGetx.updateLstRecipeDisplayed(
                              recipeEntities.map((x) => x.toModel()).toList());
                          return RefreshIndicator(
                            onRefresh: () => refreshList(),
                            child: Obx(() {
                              orderBy(recipeEntities);
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: recipeGetx.lstRecipe.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String name =
                                      recipeGetx.lstRecipe[index].title!;
                                  int id =
                                      recipeGetx.lstRecipe[index].idRecipe!;
                                  bool isFavorite =
                                      recipeGetx.lstRecipe[index].isFavorite! ==
                                              1
                                          ? true
                                          : false;
                                  return SearchDisplayCard(
                                    () =>
                                        recipeService.clickOnCard(id, context),
                                    ListTile(
                                      leading: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_outline,
                                        color: Colors.red,
                                      ),
                                      title: Text(name),
                                    ),
                                  );
                                },
                              );
                            }),
                          );
                        },
                      );
                      return widgetToDisplay;
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
