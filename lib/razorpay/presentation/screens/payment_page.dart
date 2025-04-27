import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/homepage/presentation/screens/home_page.dart';
import 'package:foodies/razorpay/presentation/bloc/payment_bloc.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
      ),
      body: Center(
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const CircularProgressIndicator();
            } else if (state is PaymentSuccess) {
              return _container('Payment Successful', true, context);
            } else if (state is PaymentFailure) {
              Navigator.of(context).pop();
            }
            return const Text('Processing Payment...');
          },
        ),
      ),
    );
  }

  Widget _container(String message, bool isPaymentSuccess, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (isPaymentSuccess)
            ? const Icon(Icons.check_circle, color: Colors.green, size: 64)
            : const Icon(Icons.error, color: Colors.red, size: 64),
        const SizedBox(height: 20),
        Text(
          message,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: (isPaymentSuccess) ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (isPaymentSuccess) {
              // Navigate to next screen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            } else {
              // Retry payment
              Navigator.of(context).pop();
            }
          },
          child: (isPaymentSuccess) ? const Text('Continue') : const Text('Retry Payment'),
        ),
        const SizedBox(height: 20),
        (!isPaymentSuccess)
            ? ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text('Cancel'),
              )
            : Container(),
      ],
    );
  }
}
