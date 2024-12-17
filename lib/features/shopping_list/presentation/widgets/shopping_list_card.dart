import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingListCard extends StatefulWidget {
  String? item;

  ShoppingListCard(this.item, {super.key});

  @override
  State<ShoppingListCard> createState() => _ShoppingListCardState();
}

class _ShoppingListCardState extends State<ShoppingListCard> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
          initialValue: widget.item,
        ));
  }
}
