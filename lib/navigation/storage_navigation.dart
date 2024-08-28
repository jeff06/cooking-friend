import 'package:cooking_friend/screens/storage/storage_add.dart';
import 'package:cooking_friend/screens/storage/storage_view.dart';
import 'package:flutter/material.dart';

import '../river/services/isar_service.dart';

class StorageNavigation extends StatefulWidget {
  final IsarService service;

  const StorageNavigation(this.service, {super.key});

  @override
  State<StorageNavigation> createState() => _StorageNavigationState();
}

GlobalKey<NavigatorState> storageNavigatorKey = GlobalKey<NavigatorState>();

class _StorageNavigationState extends State<StorageNavigation> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: storageNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          if (settings.name == "/storageAdd") {
            return StorageAdd(widget.service);
          }
          return StorageView(widget.service);
        });
      },
    );
  }
}
