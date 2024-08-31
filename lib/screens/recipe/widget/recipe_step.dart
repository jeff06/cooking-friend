import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class RecipeStep extends StatefulWidget {
  final int index;

  const RecipeStep(this.index, {super.key});

  @override
  State<RecipeStep> createState() => _RecipeStepState();
}

class _RecipeStepState extends State<RecipeStep> {
  final RecipeController controller = Get.find<RecipeController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: FormBuilderTextField(
              name: "recipe_step_${widget.index}",
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(),
                ],
              ),
            ),
          ),
          IconButton(
            color: Colors.amber,
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.addEmptySteps(widget.index + 1);
            },
          ),
        ],
      ),
    );
  }
}
