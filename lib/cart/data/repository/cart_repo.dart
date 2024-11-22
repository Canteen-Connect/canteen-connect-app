import 'dart:convert';
import 'package:foodies/canteen%20items/presentation/model/Item.dart';
import 'package:foodies/cart/data/provider/cart_provider.dart';

class CartRepo {
  Future<Map<String, dynamic>> getCart() async {
    final response = await CartProvider().getCart();
    if (response.isRight) {
      Map<String, dynamic> cart = {};
      List<Item> cartItems = [];
      String cartId = jsonDecode(response.right.body)['cart']['_id'].toString();
      final List<dynamic> products = jsonDecode(response.right.body)['cart']['products'];
      for (var product in products) {
        cartItems.add(
          Item(
            id: product['product']['_id'].toString(),
            name: product['product']['name'].toString(),
            price: product['product']['price'].toString(),
            photo: product['product']['photo'].toString(),
            description: product['product']['description'].toString(),
            quantity: product['quantity'].toString(),
            category: product['product']['category'].toString(),
            cookingTime: product['product']['cookingTime'].toString(),
            isAvailable: product['product']['isAvailable'].toString() == 'true' ? true : false,
            vendor: product['product']['vendor'].toString(),
          ),
        );
      }
      cart['cartItems'] = cartItems;
      cart['totalPrice'] = jsonDecode(response.right.body)['cart']['total'];
      cart['cartId'] = cartId;
      return cart;
    } else {
      throw response.left;
    }
  }

  Future<void> updateCart(String productId, String quantity) async {
    final response = await CartProvider().updateCart(productId, quantity);
    if (response.isRight) {
      print(response.right.body);
    } else {
      throw response.left;
    }
  }

  Future<void> deleteProduct(String productId) async {
    final response = await CartProvider().deleteProduct(productId);
    if (response.isRight) {
      print(response.right.body);
    } else {
      throw response.left;
    }
  }
}
