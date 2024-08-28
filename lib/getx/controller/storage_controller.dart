import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/screens/support/barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StorageController extends GetxController {
  var barcode = "".obs;
  int currentId = -1;
  var action = StorageManagementAction.none.name.obs;

  updateSelectedId(int selectedId) {
    currentId = selectedId;
  }

  updateAction(StorageManagementAction newAction){
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
