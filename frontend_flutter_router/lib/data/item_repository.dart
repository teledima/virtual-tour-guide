import 'package:frontend_flutter_router/models.dart';

class ItemRepository {
  Future<List<Item>> fetchItems() async {
    return Future.delayed(const Duration(seconds: 3))
      .then((value) => List.generate(10, (index) => Item(id: index.toString(), title: 'test $index')));
  }

  Future<Item> fetchItemDetail(String id) async {
    return Future.delayed(const Duration(seconds: 3))
      .then((value) => Item(id: id, title: 'test $id', detail: 'detail $id'));
  }
}