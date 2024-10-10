import 'dart:async';
import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/repositories/recipe_repository.dart';
import 'package:cooking_friend/features/recipe/business/usecases/recipe_use_case.dart';
import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/features/recipe/business/entities/recipe_modification_entity.dart';
import 'package:cooking_friend/features/recipe/presentation/widgets/recipe_form.dart';
import 'package:cooking_friend/skeleton/theme/widget/gradient_background.dart';
import 'package:cooking_friend/global_widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:http/http.dart' as http;

class RecipeManagement extends StatefulWidget {
  final IRecipeRepositoryImplementation repository;

  const RecipeManagement(this.repository, {super.key});

  @override
  State<RecipeManagement> createState() => _RecipeManagementState();
}

class _RecipeManagementState extends State<RecipeManagement> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _recipeTitleController = TextEditingController();
  final RecipeGetx recipeGetx = Get.find<RecipeGetx>();
  late final RecipeUseCase recipeUseCase =
      RecipeUseCase(recipeGetx, widget.repository);
  Future<dartz.Either<Failure, RecipeEntity>> recipeToDisplay =
      Completer<dartz.Either<Failure, RecipeEntity>>().future;
  List<RecipeModificationEntity> lstRecipeModification = [];
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (recipeGetx.action == RecipeManagementAction.view.name.obs) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          recipeToDisplay =
              RecipeRepository(recipeRepository: widget.repository)
                  .getSingleRecipe(id: recipeGetx.currentId!);
        });
      });
    }
  }

  Future<void> importRecipeFromUrl() async {
    String? recipeUrl = await recipeUseCase.requestUrlToImport(context);

    setState(() {
      isLoading = true;
    });
    String urlToCall =
        'https://www.justtherecipe.com/extractRecipeAtUrl?url=$recipeUrl';
    var response = await http.get(Uri.parse(urlToCall));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      recipeUseCase.processImportedRecipe(response, _recipeTitleController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      Scaffold(
        floatingActionButton: Obx(
          () => FutureBuilder<SpeedDial>(
            future: recipeUseCase.availableFloatingAction(context, _formKey, lstRecipeModification, _recipeTitleController, importRecipeFromUrl()),
            builder: (builder, AsyncSnapshot<SpeedDial> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data as SpeedDial;
              }
              return const SpeedDial();
            },
          ),
        ),
        body: isLoading
            ? const Loading()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<dartz.Either<Failure, RecipeEntity>>(
                  future: recipeToDisplay,
                  builder: (BuildContext context,
                      AsyncSnapshot<dartz.Either<Failure, RecipeEntity>>
                          snapshot) {
                    if (snapshot.hasData ||
                        recipeGetx.action ==
                            RecipeManagementAction.add.name.obs) {
                      var widgetToDisplay = snapshot.data?.fold(
                        (failure) {
                          return Container();
                        },
                        (recipe) {
                          if (recipeGetx.action ==
                                  RecipeManagementAction.view.name.obs ||
                              recipeGetx.action ==
                                  RecipeManagementAction.edit.name.obs) {
                            _recipeTitleController.text =
                                (snapshot.data != null ? recipe.title : "")!;

                            recipeGetx
                                .updateLstRecipeStepsDisplayed(recipe.steps!);

                            recipeGetx.updateLstRecipeIngredientsDisplayed(
                                recipe.ingredients!);

                            recipeGetx.updateFavorite(
                                recipe.isFavorite == 1 ? true : false);
                          }

                          return RecipeForm(
                              _formKey, recipeGetx, _recipeTitleController);
                        },
                      );

                      return widgetToDisplay ??
                          RecipeForm(
                              _formKey, recipeGetx, _recipeTitleController);
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
