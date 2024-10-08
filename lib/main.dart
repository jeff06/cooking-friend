import 'package:cooking_friend/features/recipe/data/datasources/recipe_sqflite_data_source.dart';
import 'package:cooking_friend/features/recipe/data/repositories/recipe_repository_implementation.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/features/storage/data/datasources/storage_sqflite_data_source.dart';
import 'package:cooking_friend/features/storage/data/repositories/storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/skeleton/main_wrapper.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildDarkTheme() {
    final baseTheme = ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: CustomTheme.elementOnScreen),
        fontFamily: "Sunflower",
        brightness: Brightness.light,
        //primaryColor: Colors.grey[800],
        //hintColor: Colors.grey[850],
        textTheme: const TextTheme(
                bodySmall: TextStyle(),
                bodyMedium: TextStyle(),
                bodyLarge: TextStyle())
            .apply(bodyColor: Colors.black),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(backgroundColor: CustomTheme.backgroundColor),
        cardTheme: CardTheme(color: CustomTheme.elementOnScreen));
    return baseTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cooking friend',
      theme: _buildDarkTheme(),
      home: const MyHomePage(title: 'Cooking friend'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StorageGetx storageController = Get.put(StorageGetx());
  final RecipeGetx recipeController = Get.put(RecipeGetx());
  
  StorageRepositoryImplementation storageRepository =
      StorageRepositoryImplementation(
    localDataSource: StorageSqfliteDataSourceImpl(),
  );

  RecipeRepositoryImplementation recipeRepository =
      RecipeRepositoryImplementation(
          localDataSource: RecipeSqfliteDataSourceImpl());

  @override
  Widget build(BuildContext context) {
    return MainWrapper(storageRepository, recipeRepository);
  }
}
