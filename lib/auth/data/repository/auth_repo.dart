import 'dart:convert';
import 'package:foodies/auth/data/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  Future<Map<String, dynamic>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      http.Response response =
          await AuthProvider().signInWithEmailAndPassword(email, password);
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(String name,
      String email, String contact, String password, String address) async {
    try {
      http.Response response = await AuthProvider()
          .signUpWithEmailAndPassword(name, email, contact, password, address);
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> logOut() async {
    String res = "";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      res = 'success';
    } catch (e) {
      res = "Failed to log out user: $e";
    }
    return res;
  }
}
