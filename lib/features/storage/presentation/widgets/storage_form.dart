import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/core/errors/failure.dart';
import 'package:cooking_friend/features/storage/business/entities/storage_entity.dart';
import 'package:cooking_friend/features/storage/presentation/provider/storage_getx.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class StorageForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final dartz.Either<Failure, StorageEntity>? data;
  final StorageGetx storageController;
  final StorageEntity? storage;
  final TextEditingController textController;

  const StorageForm(this.formKey, this.data, this.storageController,
      this.storage, this.textController,
      {super.key});

  @override
  State<StorageForm> createState() => _StorageFormState();
}

class _StorageFormState extends State<StorageForm> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FormBuilder(
        key: widget.formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            FormBuilderTextField(
              initialValue: widget.data != null ? widget.storage?.name : "",
              enabled: widget.storageController.action ==
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
              initialValue: widget.storage?.date != "null"
                  ? DateTime.parse(widget.storage!.date!)
                  : null,
              enabled: widget.storageController.action ==
                      StorageManagementAction.view.name.obs
                  ? false
                  : true,
              decoration: const InputDecoration(labelText: 'Date'),
              inputType: InputType.date,
            ),
            FormBuilderTextField(
              initialValue: widget.data != null
                  ? widget.storage?.quantity.toString()
                  : "",
              enabled: widget.storageController.action ==
                      StorageManagementAction.view.name.obs
                  ? false
                  : true,
              keyboardType: const TextInputType.numberWithOptions(),
              name: 'form_product_quantity',
              decoration: const InputDecoration(labelText: 'Quantity'),
              onChanged: (newVal) {
                widget.storageController.updateBarcode(newVal);
              },
            ),
            FormBuilderTextField(
              initialValue: widget.data != null ? widget.storage?.location : "",
              enabled: widget.storageController.action ==
                      StorageManagementAction.view.name.obs
                  ? false
                  : true,
              name: 'form_product_location',
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (newVal) {
                widget.storageController.updateBarcode(newVal);
              },
            ),
            //Obx(() => Text(storageController.barcode.string)),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    controller: widget.textController,
                    enabled: widget.storageController.action ==
                            StorageManagementAction.view.name.obs
                        ? false
                        : true,
                    name: 'form_product_code',
                    decoration: const InputDecoration(labelText: 'Code'),
                    onChanged: (newVal) {
                      widget.storageController.updateBarcode(newVal);
                    },
                  ),
                ),
                Visibility(
                  visible: widget.storageController.action ==
                          StorageManagementAction.add.name.obs ||
                      widget.storageController.action ==
                          StorageManagementAction.edit.name.obs,
                  child: IconButton(
                    onPressed: () async {
                      await widget.storageController
                          .navigateAndDisplaySelection(
                              context, widget.textController);
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
  }
}
