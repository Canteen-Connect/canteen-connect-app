import 'dart:convert';
import 'package:foodies/canteen%20items/data/provider/items_povider.dart';
import 'package:foodies/canteen%20items/presentation/model/Item.dart';

class ItemRepo {
  Future<List<Item>> getItemList(String id) async {
    final response = await ItemProvider().getItems(id);
    if (response.isRight) {
      final List<Item> itemList = [];
      final List<dynamic> data = jsonDecode(response.right.body)['products'];
      for (var element in data) {
        itemList.add(
          Item(
            id: element['_id'].toString(),
            name: element['name'].toString(),
            description: element['description'].toString(),
            price: element['price'].toString(),
            category: element['category'].toString(),
            cookingTime: element['cookingTime'].toString(),
            vendor: element['vendor'].toString(),
            photo: element['photo'].toString(),
            quantity: element['quantity'].toString(),
            isAvailable: element['isAvailable'].toString() == 'true' ? true : false,
          ),
        );
      }
      print(itemList[0].photo);
      return itemList;
    } else {
      throw response.left;
    }
  }

  Future<bool> addToCart(String id, String productId, String quantity) async {
    final response = await ItemProvider().addToCart(id, productId, quantity);
    if (response.isRight) {
      Map<String, dynamic> data = jsonDecode(response.right.body);
      print(data);
      return data['success'];
    } else {
      throw response.left;
    }
  }
}
