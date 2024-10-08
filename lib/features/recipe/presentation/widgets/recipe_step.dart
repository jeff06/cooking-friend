import 'package:cooking_friend/features/recipe/business/entities/recipe_step_entity.dart';
import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:cooking_friend/skeleton/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RecipeStep extends StatefulWidget {
  final String guid = const Uuid().v4();
  final TextEditingController? tec;
  final RecipeStepEntity? step;

  RecipeStep(this.tec, this.step, {super.key});

  @override
  State<RecipeStep> createState() => _RecipeStepState();
}

class _RecipeStepState extends State<RecipeStep> {
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
              visible: controller.steps.length > 1 &&
                  controller.action != RecipeManagementAction.view.name.obs,
              child: IconButton(
                color: CustomTheme.accent,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.removeStep(widget.guid, widget.step?.idStep);
                },
              ),
            ),
            Expanded(
              child: FormBuilderTextField(
                maxLines: null,
                enabled:
                    controller.action == RecipeManagementAction.view.name.obs
                        ? false
                        : true,
                name: "rs_${widget.guid}",
                controller: widget.tec,
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
            IconButton(
              color: CustomTheme.navbar,
              icon: const Icon(Icons.reorder),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
