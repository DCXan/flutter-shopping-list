import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/grocery_item.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.item});

  final GroceryItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: item.category.color,
      leading: const Icon(Icons.circle),
      title: Text(item.name),
      trailing: Text(
        item.quantity.toString(),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
