import 'package:cooking_friend/features/shopping_list/data/repositories/i_shopping_list_repository_implementation.dart';
import 'package:cooking_friend/features/shopping_list/presentation/provider/shopping_list_getx.dart';
import 'package:cooking_friend/features/shopping_list/presentation/widgets/shopping_list_single.dart';
import 'package:cooking_friend/skeleton/theme/widget/gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ShoppingListView extends StatefulWidget {
  final IShoppingListRepositoryImplementation storageRepository;

  const ShoppingListView(this.storageRepository, {super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  final ShoppingListGetx shoppingListGetx = Get.find<ShoppingListGetx>();

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
                        shoppingListGetx.addEmptyShoppingList();
                      },
                      icon: const Icon(Icons.add)),
                  ReorderableListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      header: const Text("All shopping list"),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var element =
                            ShoppingListSingle(shoppingListGetx, index);

                        return Container(
                            key: ValueKey(element), child: element);
                      },
                      itemCount: shoppingListGetx.shoppingList.length,
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
