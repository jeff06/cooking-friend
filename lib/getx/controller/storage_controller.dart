import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/models/storage_item.dart';
import 'package:cooking_friend/screens/support/barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/storage_item_displayed.dart';

class StorageController extends GetxController {
  var barcode = "".obs;
  int currentId = -1;
  var action = StorageManagementAction.none.name.obs;
  var lstStorageItem = <StorageItem>[].obs;

  updateSelectedId(int selectedId) {
    currentId = selectedId;
  }

  updateLstStorageItemDisplayed(List<StorageItem> newLstStorageItem) {
    lstStorageItem.value = newLstStorageItem;
  }

  modifyLstStorageItemDisplayed(List<StorageItemModification> lst) {
    for (var v in lst) {
      switch (v.action) {
        case StorageManagementAction.add:
          lstStorageItem.add(v.item!);
          break;
        case StorageManagementAction.view:
          break;
        case StorageManagementAction.edit:
          break;
        case StorageManagementAction.none:
          break;
        case null:
          break;
      }
    }
  }

  updateAction(StorageManagementAction newAction) {
    action.value = newAction.name;
  }

  navigateAndDisplaySelection(
      BuildContext context, TextEditingController textController) async {
    final String? cameraScanResult = await Get.to(
      () => const BarcodeScanner(),
      preventDuplicates: false,
      fullscreenDialog: true,
    );
    if (cameraScanResult == null) {
      barcode.value = "";
      textController.text = "";
    } else {
      barcode.value = cameraScanResult;
      textController.text = cameraScanResult;
    }
  }

  updateBarcode(newVal) {
    barcode.value = newVal;
  }
}
