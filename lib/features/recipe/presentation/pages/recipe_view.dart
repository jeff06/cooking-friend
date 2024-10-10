import 'dart:async';

import 'package:cooking_friend/features/recipe/presentation/widgets/recipe_view_refresh.dart';
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
  late final RecipeUseCase recipeUseCase =
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

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    double tenP = (screenWidth * 0.10).floorToDouble();
    return GradientBackground(
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            recipeGetx.updateAction(RecipeManagementAction.add);
            await recipeUseCase.updateList("/recipeAdd", context);
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
                recipeUseCase.updateFilterRules,
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
                      var widgetToDisplay = snapshot.data!.fold((failure) {
                        return const Text("FAILED");
                      }, (recipeEntities) {
                        recipeGetx.updateLstRecipeDisplayed(
                            recipeEntities.map((x) => x.toModel()).toList());
                        return RecipeViewRefresh(refreshList(), recipeUseCase, recipeEntities, recipeGetx);
                      });
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
