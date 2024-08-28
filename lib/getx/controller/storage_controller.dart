import 'package:cooking_friend/screens/support/barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:flutter/material.dart';

class StorageController extends GetxController {
  var barcode = "".obs;

  navigateAndDisplaySelection(BuildContext context, TextEditingController textController) async {
    final String? cameraScanResult = await Get.to(
      () => const BarcodeScanner(),
      preventDuplicates: false,
      fullscreenDialog: true,
    );
    barcode.value = cameraScanResult!;
    textController.text = cameraScanResult;
  }

  updateBarcode(newVal){
    barcode.value = newVal;
  }
}
