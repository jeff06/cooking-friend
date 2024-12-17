import 'package:cooking_friend/features/shopping_list/data/models/shopping_list_model.dart';

class ShoppingListEntity {
  int? idShoppingList;
  String? name;

  ShoppingListEntity(this.idShoppingList, this.name);

  ShoppingListModel toModel([int? newId]) {
    return ShoppingListModel(newId ?? idShoppingList, name);
  }
}
