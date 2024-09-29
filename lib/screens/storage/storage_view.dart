import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/features/storage/data/models/storage_item.dart';
import 'package:cooking_friend/getx/services/storage_service.dart';
import 'package:cooking_friend/screens/support/gradient_background.dart';
import 'package:cooking_friend/screens/support/search_bar_custom.dart';
import 'package:cooking_friend/screens/support/search_display_card.dart';
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
  TextEditingController searchBarController = TextEditingController();
  final StorageController storageController = Get.find<StorageController>();
  late final StorageService storageService =
      StorageService(storageController, widget.service);
  Future<List<StorageItem>> storageItemToDisplay =
      Completer<List<StorageItem>>().future;

  Future<void> refreshList() async {
    setState(() {
      storageItemToDisplay =
          widget.service.getAllStorageItemByFilter(searchBarController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshList();
    });
  }

  void updateFilterRules(String orderBy, String direction) {
    storageController.currentDirection =
        OrderByDirection.values.firstWhere((x) => x.paramName == direction);

    storageController.currentOrderBy =
        StorageOrderBy.values.firstWhere((x) => x.paramName == orderBy);
  }

  Future<void> orderBy(List<StorageItem> lstStorageItem) async {
    switch (storageController.currentOrderBy) {
      case StorageOrderBy.id:
        if (storageController.currentDirection == OrderByDirection.ascending) {
          lstStorageItem.sort((a, b) => a.id.compareTo(b.id));
        } else {
          lstStorageItem.sort((a, b) => b.id.compareTo(a.id));
        }
      case StorageOrderBy.name:
        if (storageController.currentDirection == OrderByDirection.ascending) {
          lstStorageItem.sort((a, b) => a.name!.compareTo(b.name!));
        } else {
          lstStorageItem.sort((a, b) => b.name!.compareTo(a.name!));
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    double tenP = (screenWidth * 0.10).floorToDouble();
    return GradientBackground(
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            storageController.updateAction(StorageManagementAction.add);
            await storageService.updateList("/storageAdd", context);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBarCustom(
                searchBarController,
                refreshList,
                updateFilterRules,
                IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    await storageController.navigateAndDisplaySelection(
                        context, searchBarController);
                    refreshList();
                  },
                  icon: const Icon(Icons.camera),
                ),
                StorageOrderBy.values.map((toElement) {
                  return toElement.paramName;
                }).toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(tenP, 0, tenP, 10),
                child: FutureBuilder<List<StorageItem>>(
                  future: storageItemToDisplay,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      storageController
                          .updateLstStorageItemDisplayed(snapshot.data!);
                      return RefreshIndicator(
                        onRefresh: () => refreshList(),
                        child: Obx(
                          () {
                            orderBy(snapshot.data!);
                            return ListView.builder(
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
                                return SearchDisplayCard(
                                  () async => await storageService.clickOnCard(
                                      id, context),
                                  ListTile(
                                    leading: const Icon(Icons.album),
                                    title: ClipRect(
                                      child: Text(name,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ),
                                    subtitle: ClipRect(
                                      child: date == "null"
                                          ? Container()
                                          : Text(date,
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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
      ),
    );
  }
}
