import 'package:cooking_friend/features/shopping_list/business/entities/shopping_list_entity.dart';
import 'package:cooking_friend/features/shopping_list/business/entities/shopping_list_item_entity.dart';
import 'package:get/get.dart';

class ShoppingListGetx extends GetxController {
  var shoppingList = <ShoppingListEntity>[].obs;
  
  void addEmptyShoppingList() {
    shoppingList.add(ShoppingListEntity.empty());
  }

  void addEmptyElementInCurrentShoppingList(int index) {
    shoppingList[index].items?.add(ShoppingListItemEntity.empty());
  }
}
