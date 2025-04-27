import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:foodies/auth/presentation/model/user.dart';
import 'package:foodies/core/secrets/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider {
  Future<Either<Exception, http.Response>> getCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
      final String userId = user.id;
      final String token = prefs.getString('token')!;
      final response = await http.get(Uri.parse('$URL/cart/user-cart/$userId'), headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }).timeout(
        const Duration(seconds: 10),
      );
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }

  Future<Either<Exception, http.Response>> updateCart(String productId, String quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
      final String userId = user.id;
      final String token = prefs.getString('token')!;
      final response = await http
          .post(Uri.parse('$URL/cart/add-product'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(<String, String>{
                'id': userId,
                'productId': productId,
                'quantity': quantity,
              }))
          .timeout(
            const Duration(seconds: 10),
          );
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }

  Future<Either<Exception, http.Response>> deleteProduct(String productId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
      final String userId = user.id;
      final String token = prefs.getString('token')!;
      print('token: $token' + 'userId: $userId' + 'productId: $productId');
      final response = await http
          .delete(Uri.parse('$URL/cart/remove-product'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode(<String, String>{
                "id": userId,
                "productId": productId,
              }))
          .timeout(const Duration(seconds: 10));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }
}
