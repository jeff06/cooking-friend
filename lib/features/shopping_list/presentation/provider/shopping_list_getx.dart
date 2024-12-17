import 'package:cooking_friend/features/shopping_list/business/entities/shopping_list_item_entity.dart';
import 'package:get/get.dart';

class ShoppingListGetx extends GetxController {
  var currentShoppingListItem = <ShoppingListItemEntity>[].obs;

  void addEmptyElementInCurrentShoppingList() {
    currentShoppingListItem.add(ShoppingListItemEntity.empty());
  }
}
