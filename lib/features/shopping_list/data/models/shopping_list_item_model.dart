import 'package:cooking_friend/features/shopping_list/business/entities/shopping_list_item_entity.dart';

class ShoppingListItemModel extends ShoppingListItemEntity {
  ShoppingListItemModel(super.idItem, super.idShoppingList, super.order,
      super.item, super.quantity);

  factory ShoppingListItemModel.fromJson(Map<String, Object?> json) {
    return ShoppingListItemModel(
      int.parse(json['idItem'].toString()),
      int.parse(json['idShoppingList'].toString()),
      int.parse(json['order'].toString()),
      json['item'] != null ? json['step'].toString() : "",
      int.parse(json['quantity'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idItem'] = idItem;
    data['idShoppingList'] = idShoppingList;
    data['order'] = order;
    data['item'] = item;
    data['quantity'] = quantity;

    return data;
  }
}
