import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:foodies/core/secrets/constants/constant.dart';
import 'package:http/http.dart' as http;

class PaymentDataProvider {
  Future<Either<Exception, http.Response>> createPayment(String paymentId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$URL/payment/create-payment'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'payment_id': paymentId,
            }),
          )
          .timeout(
            const Duration(seconds: 10),
          );
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }
}
