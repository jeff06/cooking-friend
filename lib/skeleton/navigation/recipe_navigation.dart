import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:cooking_friend/features/recipe/presentation/pages/recipe_management.dart';
import 'package:cooking_friend/features/recipe/presentation/pages/recipe_view.dart';
import 'package:flutter/material.dart';

class RecipeNavigation extends StatefulWidget {
  final IRecipeRepositoryImplementation repository;

  const RecipeNavigation(this.repository, {super.key});

  @override
  State<RecipeNavigation> createState() => _RecipeNavigationState();
}

GlobalKey<NavigatorState> recipeNavigatorKey = GlobalKey<NavigatorState>();

class _RecipeNavigationState extends State<RecipeNavigation> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: recipeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          if (settings.name == "/recipeAdd" || settings.name == "/recipeManagement") {
            return RecipeManagement(widget.repository);
          }
          return RecipeView(widget.repository);
        });
      },
    );
  }
}
