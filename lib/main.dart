import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/main_wrapper.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/theme/custom_theme.dart';
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
            .apply(bodyColor: Colors.white),
        scaffoldBackgroundColor: CustomTheme.backgroundColor,
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
  final StorageController storageController = Get.put(StorageController());
  final RecipeController recipeController = Get.put(RecipeController());
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return MainWrapper(service);
  }
}
