import 'package:cooking_friend/screens/shoppingList/shopping_list.dart';
import 'package:flutter/material.dart';

import '../river/services/isar_service.dart';

class ShoppingListNavigation extends StatefulWidget {
  final IsarService service;

  const ShoppingListNavigation(this.service, {super.key});

  @override
  State<ShoppingListNavigation> createState() => _ShoppingListNavigationState();
}

GlobalKey<NavigatorState> shoppingNavigatorKey = GlobalKey<NavigatorState>();

class _ShoppingListNavigationState extends State<ShoppingListNavigation> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: shoppingNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return const ShoppingList();
        });
      },
    );
  }
}
