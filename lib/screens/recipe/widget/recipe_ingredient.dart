import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart'
    as ri_model;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cooking_friend/constants.dart';

class RecipeIngredient extends StatefulWidget {
  final String guid = const Uuid().v4();
  final ri_model.RecipeIngredient? ingredient;
  final bool enable;

  RecipeIngredient(this.ingredient, this.enable, {super.key});

  @override
  State<RecipeIngredient> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredient> {
  final RecipeController controller = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Visibility(
              visible: controller.ingredients.length > 1,
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
              enabled: widget.enable,
              initialValue: widget.ingredient == null
                  ? ""
                  : widget.ingredient!.quantity.toString(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
              enabled: widget.enable,
              initialValue: widget.ingredient == null
                  ? ""
                  : widget.ingredient!.measuringUnit.toString(),
              name: "riu_${widget.guid}",
              items: measurementUnits,
            ),
          ),
          Expanded(
            child: FormBuilderTextField(
              enabled: widget.enable,
              initialValue: widget.ingredient == null
                  ? ""
                  : widget.ingredient!.ingredient.toString(),
              name: "ri_${widget.guid}",
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()],
              ),
            ),
          ),
          IconButton(
            color: Colors.amber,
            icon: const Icon(Icons.add),
            onPressed: widget.enable ? () => controller.addEmptyIngredient(widget.guid) : null,
          ),
        ],
      ),
    );
  }
}
