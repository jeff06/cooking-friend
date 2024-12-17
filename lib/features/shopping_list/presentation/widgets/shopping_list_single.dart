import 'package:cooking_friend/features/shopping_list/presentation/provider/shopping_list_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ShoppingListSingle extends StatefulWidget {
  final ShoppingListGetx shoppingListGetx;
  final int indexOfShoppingList;

  const ShoppingListSingle(this.shoppingListGetx, this.indexOfShoppingList,
      {super.key});

  @override
  State<ShoppingListSingle> createState() => _ShoppingListSingleState();
}

class _ShoppingListSingleState extends State<ShoppingListSingle> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          IconButton(
              onPressed: () {
                widget.shoppingListGetx.addEmptyElementInCurrentShoppingList(widget.indexOfShoppingList);
              },
              icon: const Icon(Icons.add)),
          ReorderableListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              header: const Text("Shopping list"),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var element = Obx(
                  () => TextFormField(
                    initialValue: widget.shoppingListGetx
                        .shoppingList[widget.indexOfShoppingList].name,
                  ),
                );
                return Container(key: ValueKey(element), child: element);
              },
              itemCount: widget.shoppingListGetx
                          .shoppingList[widget.indexOfShoppingList].items ==
                      null
                  ? 0
                  : widget.shoppingListGetx
                      .shoppingList[widget.indexOfShoppingList].items!.length,
              onReorder: (int oldIndex, int newIndex) {})
        ],
      ),
    );
  }
}
