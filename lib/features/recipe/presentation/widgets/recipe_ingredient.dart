import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/features/recipe/data/models/recipe_ingredient_model.dart'
    as ri_model;
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cooking_friend/skeleton/constants.dart';

class RecipeIngredient extends StatefulWidget {
  final String guid = const Uuid().v4();
  final ri_model.RecipeIngredientModel? ingredient;

  RecipeIngredient(this.ingredient, {super.key});

  @override
  State<RecipeIngredient> createState() => _RecipeIngredientState();
}

class _RecipeIngredientState extends State<RecipeIngredient> {
  final RecipeGetx controller = Get.find<RecipeGetx>();

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
                    : widget.ingredient!.quantity != null
                        ? widget.ingredient!.quantity.toString()
                        : "0",
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                name: "riq_${widget.guid}",
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
                    : widget.ingredient!.measuringUnit != "null"
                        ? widget.ingredient!.measuringUnit.toString()
                        : "",
                name: "riu_${widget.guid}",
                items: measurementUnits,
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
                onPressed: () => {}),
          ],
        ),
      ),
    );
  }
}
