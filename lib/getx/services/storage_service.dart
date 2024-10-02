import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/features/storage/business/repositories/i_storage_repository.dart';
import 'package:cooking_friend/features/storage/data/models/storage_model.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/features/storage/data/models/storage_modification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class StorageService {
  final StorageController storageController;
  final IStorageRepository storageRepository;

  StorageService(this.storageController, this.storageRepository);

  //#region Public
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

  //#endregion

  //#region Private
  Future<void> _delete(List<StorageItemModification> lstStorageItemModification,
      BuildContext context) async {
    await storageRepository.deleteStorageItem(id: storageController.currentId).then(
      (res) {
        res.fold((currentFailure){}, (currentBool){
          lstStorageItemModification.add(StorageItemModification()
            ..id = storageController.currentId
            ..action = StorageManagementAction.delete
            ..item = null);
        });
      },
    );
  }

  Future<void> _saveUpdate(
      StorageModel item,
      List<StorageItemModification> lstStorageItemModification,
      GlobalKey<FormBuilderState> formKey) async {
    if (storageController.action == StorageManagementAction.edit.name.obs) {
      await storageRepository
          .updateStorageItem(
              storageItem: item, currentId: storageController.currentId)
          .then((res) {
        res.fold((currentFailure) {}, (currentId) {
          lstStorageItemModification.add(StorageItemModification()
            ..id = storageController.currentId
            ..action = StorageManagementAction.edit
            ..item = item);
        });
      });
    } else {
      await storageRepository.saveNewStorageItem(storageItem: item).then((res) {
        res.fold((currentFailure) {}, (currentId) {
          item.id = currentId;
          lstStorageItemModification.add(StorageItemModification()
            ..id = currentId
            ..action = StorageManagementAction.add
            ..item = item);
          formKey.currentState!.reset();
        });
      });
    }
  }

  Future<void> _save(GlobalKey<FormBuilderState> formKey, BuildContext context,
      List<StorageItemModification> lstStorageItemModification) async {
    // Validate and save the form values
    if (formKey.currentState!.saveAndValidate()) {
      StorageModel item = StorageModel(
          formKey.currentState?.value["form_product_name"],
          formKey.currentState?.value["form_product_date"],
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
