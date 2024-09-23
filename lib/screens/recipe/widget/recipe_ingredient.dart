import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_ingredient.dart'
    as ri_model;
import 'package:cooking_friend/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cooking_friend/constants.dart';

class RecipeIngredient extends StatefulWidget {
  final String guid = const Uuid().v4();
  final ri_model.RecipeIngredient? ingredient;

  RecipeIngredient(this.ingredient, {super.key});

  @override
  State<RecipeIngredient> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredient> {
  final RecipeController controller = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        color: Theme.of(context).cardTheme.color,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: controller.ingredients.length > 1 &&
                  controller.action != RecipeManagementAction.view.name.obs,
              child: IconButton(
                color: CustomTheme.accent,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeIngredient(
                      widget.guid, widget.ingredient?.id);
                },
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                enabled:
                    controller.action == RecipeManagementAction.view.name.obs
                        ? false
                        : true,
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
                decoration: const InputDecoration(
                  labelText: "Unit",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                enabled:
                    controller.action == RecipeManagementAction.view.name.obs
                        ? false
                        : true,
                initialValue: widget.ingredient == null
                    ? ""
                    : widget.ingredient!.measuringUnit.toString(),
                name: "riu_${widget.guid}",
                items: measurementUnits,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(
                  labelText: "Ingredient",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                enabled:
                    controller.action == RecipeManagementAction.view.name.obs
                        ? false
                        : true,
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
              color: CustomTheme.navbar,
              icon: const Icon(Icons.add),
              onPressed:
                  controller.action == RecipeManagementAction.view.name.obs
                      ? null
                      : () => controller.addEmptyIngredient(widget.guid),
            ),
            IconButton(
              color: CustomTheme.navbar,
              icon: const Icon(Icons.reorder),
              onPressed:
                  controller.action == RecipeManagementAction.view.name.obs
                      ? null
                      : () => controller.addEmptyIngredient(widget.guid),
            ),
          ],
        ),
      ),
    );
  }
}
