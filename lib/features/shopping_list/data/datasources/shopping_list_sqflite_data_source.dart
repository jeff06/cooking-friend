import 'package:cooking_friend/core/connection/sqflite_connection.dart';
import 'package:cooking_friend/features/shopping_list/data/datasources/i_shopping_list_sqflite_data_source.dart';

class ShoppingListSqfliteDataSourceImpl implements IShoppingListSqfliteDataSource {
  ShoppingListSqfliteDataSourceImpl() {
    SqfliteConnection();
  }
}
