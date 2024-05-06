import 'dart:async';
import 'dart:convert';
import 'package:foodies/Models/user.dart';
import 'package:foodies/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  Future<String> signUp(String name, String email, String contact,
      String password, String repass, String address) async {
    String res = "";
    try {
      if (repass == password) {
        Users user = Users(
          name: name,
          email: email,
          contact: contact,
          password: password,
          address: address,
        );
        var response = await http
            .post(
              Uri.parse('$URL/users/register-user'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(user.toJson()),
            )
            .timeout(const Duration(seconds: 20));
        if (response.statusCode >= 200 && response.statusCode < 300) {
          res = 'success';
          print(response);
        } else {
          final data = jsonDecode(response.body);
          res = (data['message'].toString());
          print(response.body + res);
        }
      } else {
        res = "Password does not match";
      }
    } on TimeoutException catch (e) {
      print(e);
      res = "Connection Timeout";
    } catch (e) {
      res = "Failed to register user: $e";
    }
    return res;
  }

  Future<String> loginUser(String email, String password) async {
    String res = "";
    try {
      var response = await http
          .post(
            Uri.parse('$URL/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 20));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        res = 'success';
        print(data['token']);
      } else {
        final data = jsonDecode(response.body);
        res = (data['message'].toString());
        print(response.body);
      }
    } on TimeoutException catch (e) {
      print(e);
      res = "Connection Timeout";
    } catch (e) {
      res = "Failed to log in user: $e";
    }
    return res;
  }

  Future<String> logoutUser() async {
    String res = "";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      res = 'success';
    } catch (e) {
      res = "Failed to log out user: $e";
      print(e);
    }
    return res;
  }
}
