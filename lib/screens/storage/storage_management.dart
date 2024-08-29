import 'dart:async';

import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/getx/models/storage_item.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
            storageController.action != StorageManagementAction.add.name.obs
                ? <Widget>[
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          storageController.action ==
                                  StorageManagementAction.view.name.obs
                              ? Icons.edit
                              : Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (storageController.action ==
                              StorageManagementAction.view.name.obs) {
                            storageController
                                .updateAction(StorageManagementAction.edit);
                          } else {
                            storageController
                                .updateAction(StorageManagementAction.view);
                          }
                        },
                      ),
                    )
                  ]
                : [],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Obx(
          () => Text(
            "${storageController.action.string} storage item",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 52, 52),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<StorageItem?>(
          future: storageItemToDisplay,
          builder:
              (BuildContext context, AsyncSnapshot<StorageItem?> snapshot) {
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
                        initialValue:
                            snapshot.data != null ? snapshot.data?.name : "",
                        enabled: storageController.action ==
                                StorageManagementAction.view.name.obs
                            ? false
                            : true,
                        name: 'form_product_name',
                        decoration: const InputDecoration(labelText: 'Name'),
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
                        decoration: const InputDecoration(labelText: 'Date'),
                        inputType: InputType.date,
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                      //Obx(() => Text(storageController.barcode.string)),
                      Row(
                        children: [
                          Expanded(
                            child: FormBuilderTextField(
                              controller: _textController,
                              enabled: storageController.action ==
                                      StorageManagementAction.view.name.obs
                                  ? false
                                  : true,
                              name: 'form_product_code',
                              decoration:
                                  const InputDecoration(labelText: 'Code'),
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(),
                                ],
                              ),
                              onChanged: (newVal) {
                                storageController.updateBarcode(newVal);
                              },
                            ),
                          ),
                          Visibility(
                            visible: storageController.action ==
                                    StorageManagementAction.add.name.obs ||
                                storageController.action ==
                                    StorageManagementAction.edit.name.obs,
                            child: IconButton(
                              onPressed: () {
                                storageController.navigateAndDisplaySelection(
                                    context, _textController);
                              },
                              icon: const Icon(Icons.camera),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: storageController.action ==
                                StorageManagementAction.add.name.obs ||
                            storageController.action ==
                                StorageManagementAction.edit.name.obs,
                        child: MaterialButton(
                          color: Colors.amber,
                          onPressed: () {
                            // Validate and save the form values
                            if (_formKey.currentState!.saveAndValidate()) {
                              String name = _formKey
                                  .currentState?.value["form_product_name"];
                              DateTime date = _formKey
                                  .currentState?.value["form_product_date"];
                              String code = _formKey
                                  .currentState?.value["form_product_code"];
                              StorageItem item = StorageItem()
                                ..name = name
                                ..date = date
                                ..code = code;
                              if (storageController.action ==
                                  StorageManagementAction.edit.name.obs) {
                                widget.service.updateStorageItem(
                                    item, storageController.currentId);
                              } else {
                                widget.service.saveNewStorageItem(item);
                                _formKey.currentState!.reset();
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      storageController.action.string == "add"
                                          ? "New storage item added"
                                          : "Storage item edited"),
                                ),
                              );
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ),
                      Visibility(
                        visible: storageController.action ==
                                StorageManagementAction.add.name.obs ||
                            storageController.action ==
                                StorageManagementAction.edit.name.obs,
                        child: IconButton(
                          color: Colors.amber,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            widget.service
                                .deleteStorageItem(storageController.currentId);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Placeholder();
            }
          },
        ),
      ),
    );
  }
}
