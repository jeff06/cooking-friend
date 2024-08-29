import 'package:cooking_friend/navigation/recipe_navigation.dart';
import 'package:cooking_friend/navigation/shopping_list_navigation.dart';
import 'package:cooking_friend/navigation/storage_navigation.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainWrapper extends StatefulWidget {
  final IsarService service;

  const MainWrapper(this.service, {super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    storageNavigatorKey,
    recipeNavigatorKey,
    shoppingNavigatorKey
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex]
          .currentState
          ?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          destinations: const <NavigationDestination>[
            NavigationDestination(icon: Icon(Icons.kitchen), label: "Storage"),
            NavigationDestination(icon: Icon(Icons.fastfood), label: "Recipe"),
            NavigationDestination(icon: Icon(Icons.receipt), label: "Shopping list"),

          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              StorageNavigation(widget.service),
              RecipeNavigation(widget.service),
              ShoppingListNavigation(widget.service),
            ],
          ),
        ),
      ),
    );
  }
}
