import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/data/categories.dart';

import 'package:flutter_shopping_list/models/grocery_item.dart';
import 'package:flutter_shopping_list/widgets/list_item.dart';
import 'package:flutter_shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];

  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-grocery-list-46ae2-default-rtdb.firebaseio.com',
        'shopping-list.json');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Failed to retrieve items. Please try again later.';
      });
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItemsList = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((categoryItem) =>
              categoryItem.value.title == item.value['category'])
          .value;

      loadedItemsList.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = loadedItemsList;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: ((context, index) {
        var item = _groceryItems[index];
        return ListItem(
          item: item,
          onRemoveItem: _removeItem,
        );
      }),
    );
    if (_groceryItems.isEmpty) {
      content = const Center(
        child: Text("Grocery List is empty!"),
      );
    }

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content);
  }
}
