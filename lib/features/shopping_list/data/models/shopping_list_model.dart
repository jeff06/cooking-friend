import 'package:cooking_friend/features/shopping_list/business/entities/shopping_list_entity.dart';

class ShoppingListModel extends ShoppingListEntity {
  ShoppingListModel(super.idShoppingList, super.name);

  factory ShoppingListModel.fromJson(Map<String, Object?> json) {
    return ShoppingListModel(
        int.parse(json['idShoppingList'].toString()), json['name'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idRecipe'] = idShoppingList;
    data['name'] = name;

    return data;
  }
}
