import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/data/dummy_items.dart';
import 'package:flutter_shopping_list/widgets/list_item.dart';
import 'package:flutter_shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final items = groceryItems;

  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: ((context, index) {
          var item = items[index];
          return ListItem(item: item);
        }),
      ),
    );
  }
}
