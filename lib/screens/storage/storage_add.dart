import 'package:cooking_friend/getx/controller/storage_controller.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../getx/models/storage_item.dart';

class StorageAdd extends StatefulWidget {
  final IsarService service;

  const StorageAdd(this.service, {super.key});

  @override
  State<StorageAdd> createState() => _StorageAddState();
}

class _StorageAddState extends State<StorageAdd> {
  final _formKey = GlobalKey<FormBuilderState>();
  final StorageController storageController = Get.find<StorageController>();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Add to storage",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 210, 52, 52),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              FormBuilderTextField(
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
                      name: 'form_product_code',
                      decoration: const InputDecoration(labelText: 'Code'),
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
                  IconButton(
                    onPressed: () {
                      Get.find<StorageController>().navigateAndDisplaySelection(
                          context, _textController);
                    },
                    icon: const Icon(Icons.camera),
                  ),
                ],
              ),
              MaterialButton(
                color: Colors.amber,
                onPressed: () {
                  // Validate and save the form values
                  if (_formKey.currentState!.saveAndValidate()) {
                    String name =
                        _formKey.currentState?.value["form_product_name"];
                    DateTime date =
                        _formKey.currentState?.value["form_product_date"];
                    String code =
                        _formKey.currentState?.value["form_product_code"];
                    StorageItem item = StorageItem()
                      ..name = name
                      ..date = date
                      ..code = code;

                    widget.service.saveNewStorageItem(item);
                    _formKey.currentState!.reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("New item added"),
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
