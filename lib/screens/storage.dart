import 'package:cooking_friend/river/services/isar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../river/models/storage_item.dart';

class Storage extends StatefulWidget {
  final IsarService service;

  const Storage(this.service, {super.key});

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'form_product_name',
            decoration: const InputDecoration(labelText: 'Name'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          FormBuilderDateTimePicker(
            name: "form_product_date",
            decoration: const InputDecoration(labelText: 'Date'),
            inputType: InputType.date,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          FormBuilderTextField(
            name: 'form_product_code',
            decoration: const InputDecoration(labelText: 'Code'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          MaterialButton(
            color: Colors.amber,
            onPressed: () {
              // Validate and save the form values
              if (_formKey.currentState!.saveAndValidate()) {
                String name = _formKey.currentState?.value["form_product_name"];
                DateTime date =
                    _formKey.currentState?.value["form_product_date"];
                String code = _formKey.currentState?.value["form_product_code"];
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
    );
  }
}
