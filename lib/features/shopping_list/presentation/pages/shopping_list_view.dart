import 'package:cooking_friend/features/shopping_list/data/repositories/i_shopping_list_repository_implementation.dart';
import 'package:flutter/material.dart';

class ShoppingListView extends StatefulWidget {
  final IShoppingListRepositoryImplementation storageRepository;

  const ShoppingListView(this.storageRepository, {super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
