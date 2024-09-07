import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/main_wrapper.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildDarkTheme() {
    final baseTheme = ThemeData(
        fontFamily: "Sunflower",
        brightness: Brightness.dark,
        primaryColor: Colors.grey[800],
        hintColor: Colors.grey[850],
        textTheme: const TextTheme(
                bodySmall: TextStyle(),
                bodyMedium: TextStyle(),
                bodyLarge: TextStyle())
            .apply(bodyColor: Colors.white),
        /*scaffoldBackgroundColor: const Color.fromARGB(
          255,
          255,
          184,
          108,
        ),*/
        searchBarTheme: const SearchBarThemeData(
            backgroundColor:
                WidgetStatePropertyAll(Color.fromARGB(255, 255, 121, 198))),
        appBarTheme:
            const AppBarTheme(backgroundColor: Color.fromARGB(255, 68, 71, 90)),
        cardTheme: const CardTheme(color: Color.fromARGB(255, 98, 114, 164)));
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
