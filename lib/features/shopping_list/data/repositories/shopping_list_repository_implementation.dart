import 'package:cooking_friend/features/shopping_list/data/datasources/i_shopping_list_sqflite_data_source.dart';
import 'package:cooking_friend/features/shopping_list/data/repositories/i_shopping_list_repository_implementation.dart';

class ShoppingListRepositoryImplementation
    implements IShoppingListRepositoryImplementation {
  final IShoppingListSqfliteDataSource localDataSource;

  ShoppingListRepositoryImplementation({
    required this.localDataSource,
  });
}
