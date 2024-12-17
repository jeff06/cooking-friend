import 'package:cooking_friend/features/shopping_list/data/repositories/i_shopping_list_repository_implementation.dart';
import 'package:cooking_friend/features/shopping_list/presentation/provider/shopping_list_getx.dart';
import 'package:cooking_friend/skeleton/theme/widget/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ShoppingListView extends StatefulWidget {
  final IShoppingListRepositoryImplementation storageRepository;

  const ShoppingListView(this.storageRepository, {super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  final ShoppingListGetx recipeGetx = Get.find<ShoppingListGetx>();

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      Scaffold(
        body: Obx(
          () => SingleChildScrollView(
            child: FormBuilder(
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        recipeGetx.addEmptyElementInCurrentShoppingList();
                      },
                      icon: const Icon(Icons.add)),
                  ReorderableListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      header: const Text("Shopping list"),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var element = Obx(
                          () => TextFormField(
                            initialValue:
                                recipeGetx.currentShoppingListItem[index].item,
                          ),
                        );
                        return Container(
                            key: ValueKey(element), child: element);
                      },
                      itemCount: recipeGetx.currentShoppingListItem.length,
                      onReorder: (int oldIndex, int newIndex) {})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
