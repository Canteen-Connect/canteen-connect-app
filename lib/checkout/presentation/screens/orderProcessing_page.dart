import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/checkout/data/repository/web_socket_services.dart';
import 'package:foodies/checkout/presentation/blocs/bloc/summary_bloc.dart';

class OrderProcessingPage extends StatefulWidget {
  final String userId;
  const OrderProcessingPage({super.key, required this.userId});

  @override
  _OrderProcessingPageState createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage> {
  bool isOrderProcessing = true;
  bool isOrderAccepted = false;
  late Timer _timer;
  int remainingSeconds = 120; // 2 minutes = 120 seconds
  final SocketService socketService = SocketService();
  String? orderId;
  int? amount;
  String? currency;
  @override
  void initState() {
    super.initState();
    _startOrderConfirmationTimer();
    _startCountdown();
  }

  @override
  void dispose() {
    socketService.disconnect();
    _timer.cancel();
    super.dispose();
  }

  void _startOrderConfirmationTimer() async {
    socketService.connect(widget.userId);
    socketService.onInitiatePayment = (data) {
      if (mounted && remainingSeconds > 0) {
        setState(() {
          orderId = data['orderId'];
          amount = data['amount'];
          currency = data['currency'];
          isOrderProcessing = false;
          isOrderAccepted = true;
        });
      }
    };
  }

  // Countdown for maximum wait time (2 minutes)
  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        _timer.cancel();
        if (mounted) {
          setState(() {
            isOrderProcessing = false;
            isOrderAccepted = false; // Timeout, order not confirmed
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isOrderProcessing) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                const Text(
                  'Processing your order...',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Text(
                  'Time remaining: ${_formatTime(remainingSeconds)}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ] else if (isOrderAccepted) ...[
                const Icon(Icons.check_circle, color: Colors.green, size: 64),
                const SizedBox(height: 20),
                const Text(
                  'Order Accepted!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ] else ...[
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 20),
                const Text(
                  'Order Failed (Timeout)!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: isOrderProcessing
                    ? null
                    : () {
                        if (isOrderAccepted) {
                          context.read<SummaryBloc>().add(OrderAccepted());
                        }
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  isOrderAccepted ? 'Continue' : 'Retry',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Format time in MM:SS
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
