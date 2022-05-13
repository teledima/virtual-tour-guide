import 'package:flutter/material.dart';

import 'package:frontend_flutter_router/models.dart';

class ListItemsModel extends ChangeNotifier {
  final List<Item> items;

  ListItemsModel(this.items);

  removeItem(Item item) {
    items.removeWhere((element) => element == item);
    notifyListeners();
  }

  setItems(List<Item> values) {
    items.addAll(values);
    notifyListeners();
  }
}