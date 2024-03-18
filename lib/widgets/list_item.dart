import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/grocery_item.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.item,
    required this.onRemoveItem,
  });

  final GroceryItem item;
  final Function(GroceryItem item) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      onDismissed: (direction) {
        onRemoveItem(item);

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} was removed from your list'),
          ),
        );
      },
      child: ListTile(
        iconColor: item.category.color,
        leading: const Icon(Icons.circle),
        title: Text(item.name),
        trailing: Text(
          item.quantity.toString(),
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
