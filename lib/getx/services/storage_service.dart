import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/getx/models/storage/storage_item.dart';
import 'package:cooking_friend/getx/models/storage/storage_item_modification.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class StorageService {
  final StorageController storageController;
  final IsarService isarService;

  StorageService(this.storageController, this.isarService);

  Future<void> _delete(List<StorageItemModification> lstStorageItemModification,
      BuildContext context) async {
    await isarService.deleteStorageItem(storageController.currentId).then(
      (res) {
        lstStorageItemModification.add(StorageItemModification()
          ..id = storageController.currentId
          ..action = StorageManagementAction.delete
          ..item = null);
      },
    );
  }

  Future<void> clickOnCard(int id, BuildContext context) async {
    storageController.updateSelectedId(id);
    storageController.updateAction(StorageManagementAction.view);
    if (!context.mounted) return;
    await updateList("/storageManagement", context);
  }

  Future<void> save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<StorageItemModification> lstStorageItemModification) async {
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
      List<StorageItemModification> lstStorageItemModification) async {
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

  Future<void> _saveUpdate(
      StorageItem item,
      List<StorageItemModification> lstStorageItemModification,
      BuildContext context,
      GlobalKey<FormBuilderState> formKey) async {
    if (storageController.action == StorageManagementAction.edit.name.obs) {
      await isarService
          .updateStorageItem(item, storageController.currentId)
          .then((res) {
        lstStorageItemModification.add(StorageItemModification()
          ..id = storageController.currentId
          ..action = StorageManagementAction.edit
          ..item = item);
        if (!context.mounted) return;
        Navigator.of(context).pop;
      });
    } else {
      await isarService.saveNewStorageItem(item).then((res) {
        item.id = res;
        lstStorageItemModification.add(StorageItemModification()
          ..id = res
          ..action = StorageManagementAction.add
          ..item = item);
        formKey.currentState!.reset();
      });
    }
  }

  Future<void> _save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<StorageItemModification> lstStorageItemModification) async {
    // Validate and save the form values
    if (formKey.currentState!.saveAndValidate()) {
      String name = formKey.currentState?.value["form_product_name"];
      DateTime? date = formKey.currentState?.value["form_product_date"];
      String? code = formKey.currentState?.value["form_product_code"];
      StorageItem item = StorageItem()
        ..name = name
        ..date = date
        ..code = code;
      await _saveUpdate(item, lstStorageItemModification, context, formKey)
          .then(
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
}
