import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/business/repositories/storage_repository.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/features/storage/data/models/storage_modification.dart';
import 'package:cooking_friend/features/storage/business/use_cases/storage_use_case.dart';
import 'package:cooking_friend/features/storage/presentation/widgets/storage_form.dart';
import 'package:cooking_friend/screens/support/gradient_background.dart';
import 'package:cooking_friend/screens/support/loading.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class StorageManagement extends StatefulWidget {
  final IStorageRepositoryImplementation storageRepository;

  const StorageManagement(this.storageRepository, {super.key});

  @override
  State<StorageManagement> createState() => _StorageManagementState();
}

class _StorageManagementState extends State<StorageManagement> {
  final _formKey = GlobalKey<FormBuilderState>();
  final StorageGetx storageController = Get.find<StorageGetx>();
  final TextEditingController _textController = TextEditingController();
  late final StorageUseCase storageUseCase =
      StorageUseCase(storageController, widget.storageRepository);
  List<StorageItemModification> lstStorageItemModification = [];

  Future<dartz.Either<Failure, StorageEntity>> storageItemToDisplay =
      Completer<dartz.Either<Failure, StorageEntity>>().future;

  @override
  void initState() {
    super.initState();
    if (storageController.action == StorageManagementAction.view.name.obs) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          storageItemToDisplay =
              StorageRepository(storageRepository: widget.storageRepository)
                  .getSingleStorageItem(id: storageController.currentId);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      Scaffold(
        floatingActionButton: Obx(
          () => FutureBuilder<SpeedDial>(
            future: storageUseCase.availableFloatingAction(
                context, _formKey, lstStorageItemModification),
            builder: (builder, AsyncSnapshot<SpeedDial> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data as SpeedDial;
              }
              return const SpeedDial();
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<dartz.Either<Failure, StorageEntity>>(
                future: storageItemToDisplay,
                builder: (BuildContext context,
                    AsyncSnapshot<dartz.Either<Failure, StorageEntity>>
                        snapshot) {
                  if (snapshot.hasData ||
                      storageController.action ==
                          StorageManagementAction.add.name.obs) {
                    var widgetToDisplay = snapshot.data!.fold<Widget>(
                      (currentFailure) {
                        return Container();
                      },
                      (currentStorage) {
                        _textController.text =
                            (snapshot.data != null ? currentStorage.code : "")!;
                        return StorageForm(_formKey, snapshot.data,
                            storageController, currentStorage, _textController);
                      },
                    );
                    return widgetToDisplay;
                  } else {
                    return const Loading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}