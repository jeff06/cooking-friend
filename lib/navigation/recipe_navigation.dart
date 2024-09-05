import 'package:cooking_friend/screens/recipe/recipe_management.dart';
import 'package:cooking_friend/screens/recipe/recipe_view.dart';
import 'package:flutter/material.dart';

import '../getx/services/isar_service.dart';

class RecipeNavigation extends StatefulWidget {
  final IsarService service;

  const RecipeNavigation(this.service, {super.key});

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
            return RecipeManagement(widget.service);
          }
          return RecipeView(widget.service);
        });
      },
    );
  }
}
