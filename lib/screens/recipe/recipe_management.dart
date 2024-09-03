import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:cooking_friend/getx/services/recipe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class RecipeManagement extends StatefulWidget {
  final IsarService service;

  const RecipeManagement(this.service, {super.key});

  @override
  State<RecipeManagement> createState() => _RecipeManagementState();
}

class _RecipeManagementState extends State<RecipeManagement> {
  final _formKey = GlobalKey<FormBuilderState>();
  final RecipeController controller = Get.find<RecipeController>();
  late final RecipeService _storageService =
      RecipeService(controller, widget.service);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add recipe"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _storageService.save(_formKey, context);
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: FormBuilderTextField(
                  name: "recipe_title",
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
              ),
              const Text("Steps"),
              Expanded(
                child: Obx(
                  () => ReorderableListView.builder(
                    onReorder: (int oldIndex, int newIndex) {
                      if (newIndex > oldIndex) newIndex--;
                      final step = controller.steps.removeAt(oldIndex);
                      controller.steps.insert(newIndex, step);
                    },
                    itemCount: controller.steps.length,
                    itemBuilder: (BuildContext context, int index) {
                      var element = controller.steps[index];
                      return Container(key: ValueKey(element), child: element);
                    },
                  ),
                ),
              ),
              const Text("Ingredients"),
              Expanded(
                child: Obx(
                  () => ReorderableListView.builder(
                    onReorder: (int oldIndex, int newIndex) {
                      if (newIndex > oldIndex) newIndex--;
                      final step = controller.ingredients.removeAt(oldIndex);
                      controller.ingredients.insert(newIndex, step);
                    },
                    itemCount: controller.ingredients.length,
                    itemBuilder: (BuildContext context, int index) {
                      var element = controller.ingredients[index];
                      return Container(key: ValueKey(element), child: element);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
