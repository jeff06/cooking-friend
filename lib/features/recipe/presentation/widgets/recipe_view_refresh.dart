import 'package:cooking_friend/features/recipe/business/entities/recipe_entity.dart';
import 'package:cooking_friend/features/recipe/business/usecases/recipe_use_case.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/global_widget/search_display_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeViewRefresh extends StatefulWidget {
  final Future<void> refreshList;
  final RecipeUseCase recipeUseCase;
  final List<RecipeEntity> recipeEntities;
  final RecipeGetx recipeGetx;

  const RecipeViewRefresh(this.refreshList, this.recipeUseCase,
      this.recipeEntities, this.recipeGetx,
      {super.key});

  @override
  State<RecipeViewRefresh> createState() => _RecipeViewRefreshState();
}

class _RecipeViewRefreshState extends State<RecipeViewRefresh> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.refreshList,
      child: Obx(() {
        widget.recipeUseCase.orderBy(widget.recipeEntities);
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget.recipeGetx.lstRecipe.length,
          itemBuilder: (BuildContext context, int index) {
            String name = widget.recipeGetx.lstRecipe[index].title!;
            int id = widget.recipeGetx.lstRecipe[index].idRecipe!;
            return SearchDisplayCard(
              () => widget.recipeUseCase.clickOnCard(id, context),
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
}
