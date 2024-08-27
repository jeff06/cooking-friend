import 'package:cooking_friend/navigation/storage_navigation.dart';
import 'package:cooking_friend/river/services/isar_service.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  final IsarService service;
  const MainWrapper(this.service, {super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home), label: "home"),
          NavigationDestination(icon: Icon(Icons.storage), label: "storage")
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            Container(
              color: Colors.red,
            ),
            StorageNavigation(widget.service),
          ],
        ),
      ),
    );
  }
}
