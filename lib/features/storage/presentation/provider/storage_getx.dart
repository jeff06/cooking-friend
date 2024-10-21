import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/global_widget/barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:cooking_friend/features/storage/business/entities/storage_modification_entity.dart';

class StorageGetx extends GetxController {
  var barcode = "".obs;
  int currentId = -1;
  var action = StorageManagementAction.none.name.obs;
  var lstStorageItem = <StorageEntity>[].obs;
  var lstStorageItemModification = <StorageItemModificationEntity>[].obs;
  StorageOrderBy currentOrderBy = StorageOrderBy.name;
  OrderByDirection currentDirection = OrderByDirection.ascending;

  void updateSelectedId(int selectedId) {
    currentId = selectedId;
  }

  void updateLstStorageItemDisplayed(List<StorageEntity> newLstStorageItem) {
    lstStorageItem.value = newLstStorageItem;
  }

  void updateLstStorageItemModification(List<StorageItemModificationEntity> lst) {
    lstStorageItemModification.value = lst;
  }

  void modifyLstStorageItemDisplayed() {
    for (var v in lstStorageItemModification) {
      switch (v.action) {
        case StorageManagementAction.add:
          lstStorageItem.add(v.item!.toModel());
          break;
        case StorageManagementAction.view:
          break;
        case StorageManagementAction.edit:
          lstStorageItem[lstStorageItem.indexWhere((x) => x.idStorage == v.id)] =
              v.item!.toModel();
          break;
        case StorageManagementAction.none:
          break;
        case StorageManagementAction.delete:
          lstStorageItem.removeWhere((x) => x.idStorage == v.id);
          break;
        case null:
          break;
      }
    }
    lstStorageItemModification = <StorageItemModificationEntity>[].obs;
  }

  void updateAction(StorageManagementAction newAction) {
    action.value = newAction.name;
  }

  Future<void> navigateAndDisplaySelection(
      BuildContext context, TextEditingController textController) async {
    final String? cameraScanResult = await Get.to(
      () => const BarcodeScanner(),
      preventDuplicates: false,
      fullscreenDialog: true,
    );
    if (cameraScanResult == null) {
      textController.text = "";
    } else {
      textController.text = cameraScanResult;
    }
    updateBarcode(textController.text);
  }

  void updateBarcode(newVal) {
    barcode.value = newVal;
  }
}
