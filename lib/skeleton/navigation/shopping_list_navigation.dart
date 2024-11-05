import 'package:cooking_friend/features/shopping_list/data/repositories/i_shopping_list_repository_implementation.dart';
import 'package:cooking_friend/features/shopping_list/presentation/pages/shopping_list_view.dart';
import 'package:flutter/material.dart';

class ShoppingListNavigation extends StatefulWidget {
  final IShoppingListRepositoryImplementation repository;

  const ShoppingListNavigation(this.repository, {super.key});

  @override
  State<ShoppingListNavigation> createState() => _ShoppingListNavigationState();
}

GlobalKey<NavigatorState> shoppingListNavigatorKey =
    GlobalKey<NavigatorState>();

class _ShoppingListNavigationState extends State<ShoppingListNavigation> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: shoppingListNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return ShoppingListView(widget.repository);
        });
      },
    );
  }
}
