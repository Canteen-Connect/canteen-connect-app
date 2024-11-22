import 'dart:convert';

import 'package:foodies/auth/presentation/model/user.dart';
import 'package:foodies/canteen%20items/presentation/model/Item.dart';
import 'package:foodies/order/data/provider/summary_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryRepo {
  Future<Map<String, dynamic>> getCart() async {
    final response = await SummaryProvider().getSummary();
    if (response.isRight) {
      Map<String, dynamic> cart = {};
      List<Item> cartItems = [];
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
      return cart;
    } else {
      throw response.left;
    }
  }

  Future<Map<String, String>> getCartInfo() async {
    final response = await SummaryProvider().getCartInfo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
    final String userId = user.id;
    if (response.isRight) {
      return {
        'cartId': jsonDecode(response.right.body)['cart']['_id'].toString(),
        'total': jsonDecode(response.right.body)['cart']['total'].toString(),
        'vendorId': jsonDecode(response.right.body)['cart']['products'][0]['product']['vendor'].toString(),
        'userId': userId,
      };
    } else {
      throw response.left;
    }
  }

  Future<void> createOrder(String vendorId, double total, String cartId) async {
    final response = await SummaryProvider().createOrder(vendorId: vendorId, total: total, cartId: cartId);
    if (response.isRight) {
      print(response.right.body);
      return;
    } else {
      print(response.left);
      throw response.left;
    }
  }
}
