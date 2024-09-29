import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/features/storage/data/models/storage_item.dart';
import 'package:cooking_friend/screens/support/barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:cooking_friend/features/storage/data/models/storage_item_modification.dart';

class StorageController extends GetxController {
  var barcode = "".obs;
  int currentId = -1;
  var action = StorageManagementAction.none.name.obs;
  var lstStorageItem = <StorageItem>[].obs;
  var lstStorageItemModification = <StorageItemModification>[].obs;
  StorageOrderBy currentOrderBy = StorageOrderBy.name;
  OrderByDirection currentDirection = OrderByDirection.ascending;

  void updateSelectedId(int selectedId) {
    currentId = selectedId;
  }

  void updateLstStorageItemDisplayed(List<StorageItem> newLstStorageItem) {
    lstStorageItem.value = newLstStorageItem;
  }

  void updateLstStorageItemModification(List<StorageItemModification> lst) {
    lstStorageItemModification.value = lst;
  }

  void modifyLstStorageItemDisplayed() {
    for (var v in lstStorageItemModification) {
      switch (v.action) {
        case StorageManagementAction.add:
          lstStorageItem.add(v.item!);
          break;
        case StorageManagementAction.view:
          break;
        case StorageManagementAction.edit:
          lstStorageItem[lstStorageItem.indexWhere((x) => x.id == v.id)] =
              v.item!;
          break;
        case StorageManagementAction.none:
          break;
        case StorageManagementAction.delete:
          lstStorageItem.removeWhere((x) => x.id == v.id);
          break;
        case null:
          break;
      }
    }
    lstStorageItemModification = <StorageItemModification>[].obs;
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
