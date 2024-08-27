import 'package:cooking_friend/main_wrapper.dart';
import 'package:cooking_friend/river/services/isar_service.dart';
import 'package:cooking_friend/screens/home.dart';
import 'package:cooking_friend/screens/setting.dart';
import 'package:cooking_friend/screens/storage/storage_add.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final service = IsarService();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget screenToDisplay() {
    switch (_selectedIndex) {
      case 0:
        return const Home();
      case 1:
        return StorageAdd(service);
      case 2:
        return const Setting();
      default:
        return const Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainWrapper(service),
    );
  }
}
