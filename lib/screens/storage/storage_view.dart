import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/getx/models/storage_item.dart';
import 'package:cooking_friend/getx/models/storage_item_displayed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx/services/isar_service.dart';

class StorageView extends StatefulWidget {
  final IsarService service;

  const StorageView(this.service, {super.key});

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  String currentSearchString = "";
  final StorageController storageController = Get.find<StorageController>();
  Future<List<StorageItem>> storageItemToDisplay =
      Completer<List<StorageItem>>().future;

  Future<void> refreshList() async {
    setState(() {
      storageItemToDisplay =
          widget.service.getAllStorageItemByFilter(currentSearchString);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        storageItemToDisplay =
            widget.service.getAllStorageItemByFilter(currentSearchString);
      });
    });
  }

  Future<void> updateList(String path) async {
    var listReturned = await Navigator.pushNamed(context, path);
    storageController.modifyLstStorageItemDisplayed(
        listReturned as List<StorageItemModification>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              storageController.updateAction(StorageManagementAction.add);
              await updateList("/storageAdd");
            },
          )
        ],
        title: const Text(
          "Storage",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 52, 52),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (newVal) {
              setState(
                () {
                  currentSearchString = newVal;
                },
              );
              refreshList();
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder<List<StorageItem>>(
                future: storageItemToDisplay,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data!.sort((a, b) => b.id.compareTo(a.id));
                    storageController
                        .updateLstStorageItemDisplayed(snapshot.data!);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RefreshIndicator(
                        onRefresh: () => refreshList(),
                        child: Obx(
                          () => ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount:
                                  storageController.lstStorageItem.length,
                              itemBuilder: (BuildContext context, int index) {
                                String name = storageController
                                    .lstStorageItem[index].name
                                    .toString();
                                String date = storageController
                                    .lstStorageItem[index].date
                                    .toString();
                                int id =
                                    storageController.lstStorageItem[index].id;
                                return Card(
                                  child: InkWell(
                                    onTap: () async {
                                      await storageController
                                          .updateSelectedId(id);
                                      await storageController.updateAction(
                                          StorageManagementAction.view);
                                      await updateList("/storageView");
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: const Icon(Icons.album),
                                          title: Text(name),
                                          subtitle: Text(date),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
