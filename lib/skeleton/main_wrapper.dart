import 'package:cooking_friend/features/recipe/data/repositories/i_recipe_repository_implementation.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/skeleton/navigation/recipe_navigation.dart';
import 'package:cooking_friend/skeleton/navigation/storage_navigation.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainWrapper extends StatefulWidget {
  final IStorageRepositoryImplementation storageRepository;
  final IRecipeRepositoryImplementation recipeRepository;

  const MainWrapper(this.storageRepository, this.recipeRepository, {super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    storageNavigatorKey,
    recipeNavigatorKey,
    //shoppingNavigatorKey
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
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await _systemBackButtonPressed();
      },
      child: Scaffold(
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) =>
                    states.contains(WidgetState.selected)
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.white),
              ),
              indicatorColor: CustomTheme.accent),
          child: NavigationBar(
            backgroundColor: CustomTheme.navbar,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIndex: _selectedIndex,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.kitchen, color: Colors.white),
                label: "Storage",
              ),
              NavigationDestination(
                  icon: Icon(Icons.fastfood, color: Colors.white),
                  label: "Recipe"),
              /*NavigationDestination(
                  icon: Icon(Icons.receipt), label: "Shopping list"),*/
              //NavigationDestination(icon: Icon(Icons.menu), label: "Menu of the week")
            ],
          ),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              StorageNavigation(widget.storageRepository),
              RecipeNavigation(widget.recipeRepository),
              //ShoppingListNavigation(widget.service),
            ],
          ),
        ),
      ),
    );
  }
}
