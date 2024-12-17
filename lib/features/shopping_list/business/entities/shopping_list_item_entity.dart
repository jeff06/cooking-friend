import 'package:cooking_friend/features/shopping_list/data/models/shopping_list_item_model.dart';

class ShoppingListItemEntity {
  int? idItem;
  int? idShoppingList;
  int? order;
  String? item;
  int? quantity;
  
  ShoppingListItemEntity(this.idItem, this.idShoppingList, this.order, this.item, this.quantity);
  ShoppingListItemEntity.empty();
  
  ShoppingListItemModel toModel() {
    return ShoppingListItemModel(idItem, idShoppingList, order, item, quantity);
  }
}
