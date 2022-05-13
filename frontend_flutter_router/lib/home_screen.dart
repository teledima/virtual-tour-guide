import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_flutter_router/providers/list_items.dart';
import 'package:frontend_flutter_router/models.dart';

class HomeScreen extends StatelessWidget {
  final List<Item> items;

  const HomeScreen({Key? key, required this.items }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final listItemsModel = context.watch<ListItemsModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('My App')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
          for (Item item in items) 
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Text(item.title)
                  )
                ),
                IconButton(
                  onPressed: () => listItemsModel.removeItem(item), 
                  icon: const Icon(Icons.remove_circle_outline)
                )
              ]
            )
        ]
      )
    );
  }
}