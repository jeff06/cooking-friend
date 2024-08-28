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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final StorageController controller = Get.put(StorageController());
  final service = IsarService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainWrapper(service),
    );
  }
}
