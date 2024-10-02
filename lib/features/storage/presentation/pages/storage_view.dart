import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/business/repositories/storage_repository.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_controller.dart';
import 'package:cooking_friend/features/storage/business/use_cases/storage_use_case.dart';
import 'package:cooking_friend/screens/support/gradient_background.dart';
import 'package:cooking_friend/screens/support/search_bar_custom.dart';
import 'package:cooking_friend/screens/support/search_display_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart' as dartz;

class StorageView extends StatefulWidget {
  final IStorageRepositoryImplementation storageRepository;

  const StorageView(this.storageRepository, {super.key});

  @override
  State<StorageView> createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  TextEditingController searchBarController = TextEditingController();
  final StorageController storageController = Get.find<StorageController>();
  late final StorageUseCase storageUseCase;
  late final StorageUseCase storageService =
      StorageUseCase(storageController, widget.storageRepository);
  Future<dartz.Either<Failure, List<StorageEntity>>> storageItemToDisplay =
      Completer<dartz.Either<Failure, List<StorageEntity>>>().future;

  Future<void> refreshList() async {
    setState(() {
      storageItemToDisplay =
          StorageRepository(storageRepository: widget.storageRepository)
              .getAllStorageItemByFilter(filter: searchBarController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storageUseCase =
          StorageUseCase(storageController, widget.storageRepository);
      refreshList();
    });
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
                storageUseCase.updateFilterRules,
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
                child:
                    FutureBuilder<dartz.Either<Failure, List<StorageEntity>>>(
                  future: storageItemToDisplay,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Failure? failure;
                      List<StorageEntity> lstStorages = [];
                      snapshot.data
                          !.fold((currentFailure) {
                        failure = currentFailure;
                      }, (currentStorages) {
                        lstStorages = currentStorages;
                      });

                      storageController
                          .updateLstStorageItemDisplayed(lstStorages);
                      return RefreshIndicator(
                        onRefresh: () => refreshList(),
                        child: Obx(
                          () {
                            storageUseCase.orderBy(lstStorages);
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
                                    storageController.lstStorageItem[index].id!;
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
