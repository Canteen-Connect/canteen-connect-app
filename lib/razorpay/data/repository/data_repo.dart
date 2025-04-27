import 'package:foodies/razorpay/data/provider/data_provider.dart';

class PaymentDataRepo {
  Future<String> createPayment(String paymentId) async {
    final response = await PaymentDataProvider().createPayment(paymentId);
    if (response.isRight) {
      return response.right.body;
    } else {
      throw response.left;
    }
  }
}
