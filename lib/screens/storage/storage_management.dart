import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/getx/models/storage/storage_item.dart';
import 'package:cooking_friend/getx/models/storage/storage_item_modification.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/getx/services/storage_service.dart';
import 'package:cooking_friend/screens/support/gradient_background.dart';
import 'package:cooking_friend/screens/support/loading.dart';
import 'package:cooking_friend/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class StorageManagement extends StatefulWidget {
  final IsarService service;

  const StorageManagement(this.service, {super.key});

  @override
  State<StorageManagement> createState() => _StorageManagementState();
}

class _StorageManagementState extends State<StorageManagement> {
  final _formKey = GlobalKey<FormBuilderState>();
  final StorageController storageController = Get.find<StorageController>();
  final TextEditingController _textController = TextEditingController();
  late final StorageService _storageService =
      StorageService(storageController, widget.service);
  List<StorageItemModification> lstStorageItemModification = [];

  Future<StorageItem?> storageItemToDisplay = Completer<StorageItem?>().future;

  @override
  void initState() {
    super.initState();
    if (storageController.action == StorageManagementAction.view.name.obs) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          storageItemToDisplay =
              widget.service.getSingleStorageItem(storageController.currentId);
        });
      });
    }
  }

  _save() async {
    await _storageService.save(_formKey, context, lstStorageItemModification);
    storageController
        .updateLstStorageItemModification(lstStorageItemModification);
  }

  _delete(BuildContext context) async {
    await _storageService.delete(lstStorageItemModification, context);
    storageController
        .updateLstStorageItemModification(lstStorageItemModification);
    Navigator.pop(context);
  }

  _edit() async {
    if (storageController.action == StorageManagementAction.view.name.obs) {
      await storageController.updateAction(StorageManagementAction.edit);
    } else {
      await storageController.updateAction(StorageManagementAction.view);
    }
  }

  Future<SpeedDial> availableFloatingAction(BuildContext context) async {
    List<SpeedDialChild> lst = [];
    if (storageController.action == StorageManagementAction.edit.name.obs ||
        storageController.action == StorageManagementAction.add.name.obs) {
      lst.add(SpeedDialChild(
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
        onTap: _save,
      ));
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
          onTap: _edit,
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
          onTap: () => _delete(context),
        ),
      );
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: lst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      Scaffold(
        floatingActionButton: Obx(
          () => FutureBuilder<SpeedDial>(
            future: availableFloatingAction(context),
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
              child: FutureBuilder<StorageItem?>(
                future: storageItemToDisplay,
                builder: (BuildContext context,
                    AsyncSnapshot<StorageItem?> snapshot) {
                  if (snapshot.hasData ||
                      storageController.action ==
                          StorageManagementAction.add.name.obs) {
                    _textController.text =
                        (snapshot.data != null ? snapshot.data?.code : "")!;
                    return Obx(
                      () => FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              initialValue: snapshot.data != null
                                  ? snapshot.data?.name
                                  : "",
                              enabled: storageController.action ==
                                      StorageManagementAction.view.name.obs
                                  ? false
                                  : true,
                              name: 'form_product_name',
                              decoration:
                                  const InputDecoration(labelText: 'Name'),
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(),
                                ],
                              ),
                            ),
                            FormBuilderDateTimePicker(
                              name: "form_product_date",
                              initialValue: snapshot.data?.date,
                              enabled: storageController.action ==
                                      StorageManagementAction.view.name.obs
                                  ? false
                                  : true,
                              decoration:
                                  const InputDecoration(labelText: 'Date'),
                              inputType: InputType.date,
                            ),
                            //Obx(() => Text(storageController.barcode.string)),
                            Row(
                              children: [
                                Expanded(
                                  child: FormBuilderTextField(
                                    controller: _textController,
                                    enabled: storageController.action ==
                                            StorageManagementAction
                                                .view.name.obs
                                        ? false
                                        : true,
                                    name: 'form_product_code',
                                    decoration: const InputDecoration(
                                        labelText: 'Code'),
                                    onChanged: (newVal) {
                                      storageController.updateBarcode(newVal);
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: storageController.action ==
                                          StorageManagementAction
                                              .add.name.obs ||
                                      storageController.action ==
                                          StorageManagementAction.edit.name.obs,
                                  child: IconButton(
                                    onPressed: () async {
                                      await storageController
                                          .navigateAndDisplaySelection(
                                              context, _textController);
                                    },
                                    icon: Icon(
                                      Icons.camera,
                                      color: CustomTheme.navbar,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
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
