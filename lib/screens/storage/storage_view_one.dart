import 'dart:async';

import 'package:cooking_friend/getx/models/storage_item.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';

class StorageViewOne extends StatefulWidget {
  final IsarService service;
  final int id;

  const StorageViewOne(this.service, this.id, {super.key});

  @override
  State<StorageViewOne> createState() => _StorageViewOneState();
}

class _StorageViewOneState extends State<StorageViewOne> {
  Future<StorageItem?> currentItem = Completer<StorageItem?>().future;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentItem = widget.service.getSingleStorageItem(widget.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
