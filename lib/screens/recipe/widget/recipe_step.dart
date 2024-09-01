import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RecipeStep extends StatefulWidget {
  final String guid = const Uuid().v4();

  RecipeStep({super.key});

  @override
  State<RecipeStep> createState() => _RecipeStepState();
}

class _RecipeStepState extends State<RecipeStep> {
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
              visible: controller.steps.length > 1,
              child: IconButton(
                color: Colors.amber,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  controller.hideStep(widget.guid);
                },
              ),
            ),
          ),
          Expanded(
            child: FormBuilderTextField(
              name: "rs_${widget.guid}",
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()],
              ),
            ),
          ),
          IconButton(
            color: Colors.amber,
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.addEmptyStep(widget.guid);
            },
          ),
        ],
      ),
    );
  }
}
