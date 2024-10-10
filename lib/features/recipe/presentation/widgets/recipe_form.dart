import 'package:cooking_friend/skeleton/constants.dart';
import 'package:cooking_friend/features/recipe/presentation/provider/recipe_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RecipeForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final RecipeGetx recipeGetx;
  final TextEditingController recipeTitleController;

  const RecipeForm(this.formKey, this.recipeGetx, this.recipeTitleController,
      {super.key});

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: FormBuilder(
          key: widget.formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: widget.recipeGetx.action ==
                            RecipeManagementAction.view.name.obs
                        ? null
                        : () {
                            widget.recipeGetx.updateFavorite(
                                !widget.recipeGetx.currentFavorite.value);
                          },
                    icon: Icon(
                      widget.recipeGetx.currentFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      name: "recipe_title",
                      decoration: const InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      controller: widget.recipeTitleController,
                      enabled: widget.recipeGetx.action ==
                              RecipeManagementAction.view.name.obs
                          ? false
                          : true,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Container(
                  child: widget.recipeGetx.steps.isEmpty
                      ? IconButton(
                          onPressed: () =>
                              widget.recipeGetx.addEmptyStep(const Uuid().v4()),
                          icon: const Icon(Icons.add))
                      : ReorderableListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          header: const Text("Steps"),
                          shrinkWrap: true,
                          onReorder: (int oldIndex, int newIndex) {
                            if (newIndex > oldIndex) newIndex--;
                            final step =
                                widget.recipeGetx.steps.removeAt(oldIndex);
                            widget.recipeGetx.steps.insert(newIndex, step);
                          },
                          itemCount: widget.recipeGetx.steps.length,
                          itemBuilder: (BuildContext context, int index) {
                            var element = widget.recipeGetx.steps[index];
                            return Container(
                                key: ValueKey(element), child: element);
                          },
                        ),
                ),
              ),
              Obx(
                () => Container(
                  child: widget.recipeGetx.ingredients.isEmpty
                      ? IconButton(
                          onPressed: () => widget.recipeGetx
                              .addEmptyIngredient(const Uuid().v4()),
                          icon: const Icon(Icons.add))
                      : ReorderableListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          header: const Text("Ingredients"),
                          shrinkWrap: true,
                          onReorder: (int oldIndex, int newIndex) {
                            if (newIndex > oldIndex) newIndex--;

                            final ingredient = widget.recipeGetx.ingredients
                                .removeAt(oldIndex);
                            widget.recipeGetx.ingredients
                                .insert(newIndex, ingredient);
                          },
                          itemCount: widget.recipeGetx.ingredients.length,
                          itemBuilder: (BuildContext context, int index) {
                            var element = widget.recipeGetx.ingredients[index];
                            return Container(
                                key: ValueKey(element), child: element);
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
