import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:foodies/auth/presentation/model/user.dart';
import 'package:foodies/core/secrets/constants/constant.dart';
import 'package:foodies/order/data/repository/summary_repo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SummaryProvider {
  Future<Either<Exception, http.Response>> getSummary() async {
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

  Future<Either<Exception, http.Response>> getCartInfo() async {
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

  Future<Either<Exception, http.Response>> createOrder({
    required String vendorId,
    required double total,
    required String cartId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
      final String userId = user.id;
      final String token = prefs.getString('token')!;
      final response = await http
          .post(
            Uri.parse('$URL/order/create-order'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'user': userId,
              'vendor': vendorId,
              'total': total,
              'cart': cartId,
            }),
          )
          .timeout(
            const Duration(seconds: 120),
          );
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }
}
