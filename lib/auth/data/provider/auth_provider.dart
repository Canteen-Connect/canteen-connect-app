import 'dart:convert';

import 'package:foodies/core/api/user_api.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  Future<http.Response> signInWithEmailAndPassword(
      String email, String password) async {
    http.Response response;
    try {
      response = await http
          .post(
            Uri.parse(UserApi.signInApi),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 20));
    } catch (e) {
      throw Exception('Failed to login user: $e');
    }
    return response;
  }

  Future<http.Response> signUpWithEmailAndPassword(String name, String email,
      String contact, String password, String address) async {
    http.Response response;
    try {
      Map<String, dynamic> user = {
        'name': name,
        'email': email,
        'contact': contact,
        'password': password,
        'address': address,
      };
      response = await http
          .post(
            Uri.parse(UserApi.signUpApi),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(user),
          )
          .timeout(const Duration(seconds: 20));
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
    return response;
  }
}
