import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:foodies/core/secrets/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ItemProvider {
  Future<Either<Exception, http.Response>> getItems(String id) async {
    try {
      final response = await http
          .get(
            Uri.parse('$URL/product/get-products/$id'),
          )
          .timeout(const Duration(seconds: 10));
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }

  Future<Either<Exception, http.Response>> addToCart(String id, String productId, String quantity) async {
    final Map<String, dynamic> json = {
      "id": id,
      "productId": productId,
      "quantity": quantity,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token')!;
    try {
      final response = await http
          .post(
            Uri.parse('$URL/cart/add-product'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(json),
          )
          .timeout(const Duration(seconds: 10));
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }
}
