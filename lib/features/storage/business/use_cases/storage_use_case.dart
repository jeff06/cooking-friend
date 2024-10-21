import 'package:cooking_friend/features/storage/business/entities/storage_modification_entity.dart';
import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/data/repositories/i_storage_repository_implementation.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class StorageUseCase {
  final StorageGetx storageController;
  final IStorageRepositoryImplementation storageRepository;

  StorageUseCase(this.storageController, this.storageRepository);

  void updateFilterRules(String orderBy, String direction) {
    storageController.currentDirection =
        OrderByDirection.values.firstWhere((x) => x.paramName == direction);

    storageController.currentOrderBy =
        StorageOrderBy.values.firstWhere((x) => x.paramName == orderBy);
  }

  Future<void> orderBy(List<StorageEntity> lstStorageItem) async {
    switch (storageController.currentOrderBy) {
      case StorageOrderBy.id:
        if (storageController.currentDirection == OrderByDirection.ascending) {
          lstStorageItem.sort((a, b) => a.idStorage!.compareTo(b.idStorage!));
        } else {
          lstStorageItem.sort((a, b) => b.idStorage!.compareTo(a.idStorage!));
        }
      case StorageOrderBy.name:
        if (storageController.currentDirection == OrderByDirection.ascending) {
          lstStorageItem.sort((a, b) => a.name!.compareTo(b.name!));
        } else {
          lstStorageItem.sort((a, b) => b.name!.compareTo(a.name!));
        }
    }
  }

  Future<SpeedDial> availableFloatingAction(
      BuildContext context,
      GlobalKey<FormBuilderState> formKey,
      List<StorageItemModificationEntity> lstStorageItemModification) async {
    List<SpeedDialChild> lst = [];
    if (storageController.action == StorageManagementAction.edit.name.obs ||
        storageController.action == StorageManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          onTap: () async {
            await save(formKey, context, lstStorageItemModification);
          },
        ),
      );
    }

    if (storageController.action != StorageManagementAction.add.name.obs) {
      lst.add(
        SpeedDialChild(
          child: Icon(
            storageController.action == StorageManagementAction.view.name.obs
                ? Icons.edit
                : Icons.edit_outlined,
            color: Colors.white,
          ),
          backgroundColor: CustomTheme.navbar,
          onTap: () {
            edit();
          },
        ),
      );
    }

    if (storageController.action == StorageManagementAction.edit.name.obs) {
      lst.add(
        SpeedDialChild(
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onTap: () async {
            await delete(context, lstStorageItemModification);
          },
        ),
      );
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: lst,
    );
  }

  //#region Public
  Future<void> clickOnCard(int id, BuildContext context) async {
    storageController.updateSelectedId(id);
    storageController.updateAction(StorageManagementAction.view);
    if (!context.mounted) return;
    await updateList("/storageManagement", context);
  }

  Future<void> save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<StorageItemModificationEntity> lstStorageItemModification) async {
    await _save(formKey, context, lstStorageItemModification);
    storageController
        .updateLstStorageItemModification(lstStorageItemModification);
  }

  void edit() {
    if (storageController.action == StorageManagementAction.view.name.obs) {
      storageController.updateAction(StorageManagementAction.edit);
    } else {
      storageController.updateAction(StorageManagementAction.view);
    }
  }

  Future<void> delete(BuildContext context,
      List<StorageItemModificationEntity> lstStorageItemModification) async {
    await _delete(lstStorageItemModification, context);
    storageController
        .updateLstStorageItemModification(lstStorageItemModification);
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  Future<void> updateList(String path, BuildContext context) async {
    await Navigator.pushNamed(context, path);
    storageController.modifyLstStorageItemDisplayed();
  }

  //#endregion

  //#region Private
  Future<void> _delete(List<StorageItemModificationEntity> lstStorageItemModification,
      BuildContext context) async {
    await storageRepository
        .deleteStorageItem(id: storageController.currentId)
        .then(
      (res) {
        res.fold((currentFailure) {}, (currentBool) {
          lstStorageItemModification.add(StorageItemModificationEntity()
            ..id = storageController.currentId
            ..action = StorageManagementAction.delete
            ..item = null);
        });
      },
    );
  }

  Future<void> _saveUpdate(
      StorageEntity item,
      List<StorageItemModificationEntity> lstStorageItemModification,
      GlobalKey<FormBuilderState> formKey) async {
    if (storageController.action == StorageManagementAction.edit.name.obs) {
      item.idStorage = storageController.currentId;
      await storageRepository
          .updateStorageItem(
              storageItem: item.toModel())
          .then((res) {
        res.fold((currentFailure) {}, (currentId) {
          lstStorageItemModification.add(StorageItemModificationEntity()
            ..id = storageController.currentId
            ..action = StorageManagementAction.edit
            ..item = item);
        });
      });
    } else {
      await storageRepository.saveNewStorageItem(storageItem: item.toModel()).then((res) {
        res.fold((currentFailure) {}, (currentId) {
          StorageEntity savedItem = StorageEntity(item.name, item.date, item.code,
              item.quantity, item.location, currentId);
          lstStorageItemModification.add(StorageItemModificationEntity()
            ..id = currentId
            ..action = StorageManagementAction.add
            ..item = savedItem);
          formKey.currentState!.reset();
        });
      });
    }
  }

  Future<void> _save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<StorageItemModificationEntity> lstStorageItemModification) async {
    // Validate and save the form values
    if (formKey.currentState!.saveAndValidate()) {
      StorageEntity item = StorageEntity(
          formKey.currentState?.value["form_product_name"],
          formKey.currentState?.value["form_product_date"].toString(),
          formKey.currentState?.value["form_product_code"],
          int.parse(formKey.currentState?.value["form_product_quantity"] == ""
              ? "0"
              : formKey.currentState?.value["form_product_quantity"]),
          formKey.currentState?.value["form_product_location"],
          null);

      await _saveUpdate(item, lstStorageItemModification, formKey).then(
        (res) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(storageController.action.string == "add"
                  ? "New storage item added"
                  : "Storage item edited"),
            ),
          );
        },
      );
    }
  }

//#endregion
}
