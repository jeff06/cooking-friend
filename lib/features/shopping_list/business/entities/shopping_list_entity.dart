import 'package:cooking_friend/features/shopping_list/business/entities/shopping_list_item_entity.dart';
import 'package:cooking_friend/features/shopping_list/data/models/shopping_list_model.dart';

class ShoppingListEntity {
  int? idShoppingList;
  String? name;
  List<ShoppingListItemEntity>? items;

  ShoppingListEntity(this.idShoppingList, this.name, this.items);

  ShoppingListModel toModel([int? newId]) {
    return ShoppingListModel(newId ?? idShoppingList, name, items);
  }
}
