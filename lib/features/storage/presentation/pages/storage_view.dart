import 'dart:async';

import 'package:cooking_friend/features/storage/presentation/widgets/storage_view_refresh.dart';
import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/business/repositories/storage_repository.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/features/storage/business/use_cases/storage_use_case.dart';
import 'package:cooking_friend/skeleton/theme/widget/gradient_background.dart';
import 'package:cooking_friend/global_widget/search_bar_custom.dart';
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
  final StorageGetx storageGetx = Get.find<StorageGetx>();
  late final StorageUseCase storageUseCase =
      StorageUseCase(storageGetx, widget.storageRepository);
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
            storageGetx.updateAction(StorageManagementAction.add);
            await storageUseCase.updateList("/storageAdd", context);
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
                    await storageGetx.navigateAndDisplaySelection(
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
                      var widgetToDisplay = snapshot.data!.fold<Widget>(
                        (currentFailure) {
                          return Container();
                        },
                        (currentStorages) {
                          storageGetx
                              .updateLstStorageItemDisplayed(currentStorages);
                          return StorageViewRefresh(refreshList(), storageUseCase, currentStorages, storageGetx);
                        },
                      );
                      return widgetToDisplay;
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
