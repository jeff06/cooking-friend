import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RecipeIngredient extends StatefulWidget {
  final String guid = const Uuid().v4();

  RecipeIngredient({super.key});

  @override
  State<RecipeIngredient> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredient> {
  final RecipeController controller = Get.find<RecipeController>();
  final List<DropdownMenuItem> measurementUnits = const [
    DropdownMenuItem(
      value: "cup",
      child: Text("CUP"),
    ),
    DropdownMenuItem(
      value: "g",
      child: Text("G"),
    ),
    DropdownMenuItem(
      value: "l",
      child: Text("L"),
    ),
    DropdownMenuItem(
      value: "lbs",
      child: Text("LBS"),
    ),
    DropdownMenuItem(
      value: "ml",
      child: Text("ML"),
    ),
    DropdownMenuItem(
      value: "tbs",
      child: Text("TBS"),
    ),
    DropdownMenuItem(
      value: "tsp",
      child: Text("tsp"),
    ),
    DropdownMenuItem(
      value: "unit",
      child: Text("Unit"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Visibility(
              visible: controller.steps.length > 1,
              child: IconButton(
                color: Colors.amber,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeIngredient(widget.guid);
                },
              ),
            ),
          ),
          Expanded(
            child: FormBuilderTextField(
              name: "riq_${widget.guid}",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
            ),
          ),
          Expanded(
            child: FormBuilderDropdown(
              name: "riu_${widget.guid}",
              items: measurementUnits,
            ),
          ),
          Expanded(
            child: FormBuilderTextField(
              name: "ri_${widget.guid}",
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()],
              ),
            ),
          ),
          IconButton(
            color: Colors.amber,
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.addEmptyIngredient(widget.guid);
            },
          ),
        ],
      ),
    );
  }
}
