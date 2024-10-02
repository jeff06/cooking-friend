import 'package:cooking_friend/features/storage/business/repositories/i_storage_repository.dart';
import 'package:cooking_friend/features/storage/presentation/pages/storage_management.dart';
import 'package:cooking_friend/features/storage/presentation/pages/storage_view.dart';
import 'package:flutter/material.dart';

class StorageNavigation extends StatefulWidget {
  final IStorageRepository repository;

  const StorageNavigation(this.repository, {super.key});

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
          if (settings.name == "/storageAdd" || settings.name == "/storageManagement") {
            return StorageManagement(widget.repository);
          }
          return StorageView(widget.repository);
        });
      },
    );
  }
}
