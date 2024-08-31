import 'package:cooking_friend/getx/controller/recipe_controller.dart';
import 'package:cooking_friend/getx/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: controller.steps.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Theme.of(context).cardTheme.color,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            controller.steps[index],
                          ],
                        ),
                      );
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
