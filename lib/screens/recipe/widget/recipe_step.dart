import 'package:cooking_friend/constants.dart';
import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/models/recipe/recipe_step.dart'
as rs_model;
import 'package:cooking_friend/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RecipeStep extends StatefulWidget {
  final String guid = const Uuid().v4();
  final TextEditingController? tec;
  final rs_model.RecipeStep? step;

  RecipeStep(this.tec, this.step, {super.key});

  @override
  State<RecipeStep> createState() => _RecipeStepState();
}

class _RecipeStepState extends State<RecipeStep> {
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
              visible: controller.steps.length > 1 && controller.action != RecipeManagementAction.view.name.obs,
              child: IconButton(
                color: CustomTheme.accent,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeStep(widget.guid);
                },

              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                enabled:
                    controller.action == RecipeManagementAction.view.name.obs
                        ? false
                        : true,
                name: "rs_${widget.guid}",
                controller: widget.tec,
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
                      : () => controller.addEmptyStep(widget.guid),
            ),
          ],
        ),
      ),
    );
  }
}
