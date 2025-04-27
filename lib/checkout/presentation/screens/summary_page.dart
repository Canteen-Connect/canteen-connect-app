import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/auth/presentation/model/user.dart';
import 'package:foodies/checkout/data/repository/summary_repo.dart';
import 'package:foodies/checkout/presentation/blocs/bloc/summary_bloc.dart';
import 'package:foodies/checkout/presentation/screens/orderProcessing_page.dart';
import 'package:foodies/razorpay/presentation/bloc/payment_bloc.dart';
import 'package:foodies/razorpay/presentation/screens/payment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<SummaryBloc>().add(GetSummary());
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Cancel Order'),
                content: const Text('Are you sure you want to cancel this order?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false;

        if (shouldPop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Summary'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<SummaryBloc, SummaryState>(
                builder: (context, state) {
                  if (state is SummaryLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatusStep(title: 'Processed', isActive: state.isOrderProcessing),
                        _StatusStep(title: 'Accepted', isActive: state.isOrderAccepted),
                        const _StatusStep(title: 'Payment', isActive: false),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
              _SummaryCard(),
              const SizedBox(height: 20),
              _BottomButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  final String title;
  final bool isActive;

  const _StatusStep({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? Colors.green : Colors.grey,
          child: const Icon(Icons.check, color: Colors.white, size: 16),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.red : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SummaryBloc, SummaryState>(
          builder: (context, state) {
            if (state is SummaryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SummaryLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...state.items
                      .map((item) => _SummaryRow(
                          label: '${item.name} (${item.quantity} Item)', amount: 'IDR ${item.price.toString()}'))
                      .toList(),
                  const Divider(),
                  _SummaryRow(label: 'Subtotal', amount: 'IDR ${state.totalPrice.toString()}'),
                  // const _SummaryRow(label: 'Service fee', amount: 'IDR 2.000'),
                  const Divider(),
                  _SummaryRow(label: 'Total', amount: 'IDR ${(state.totalPrice)}', isBold: true),
                ],
              );
            }
            if (state is SummaryError) {
              return const Center(
                child: Text("Cannot fetch summary"),
              );
            }
            return const Text('Cannot get summary');
          },
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isBold;

  const _SummaryRow({required this.label, required this.amount, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryBloc, SummaryState>(
      builder: (context, state) {
        if (state is SummaryLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  //CREATE ORDER
                  //PAYMENT PAGE NAVIGATOR IF ORDER PROCESSED ELSE SHOW THIS
                  Map<String, String> cartInfo = await SummaryRepo().getCartInfo();
                  if (state.isOrderAccepted) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    Users user = Users.fromJson(jsonDecode(prefs.getString('user')!));
                    final String userEmail = user.email;
                    final String userContact = user.contact;
                    context.read<PaymentBloc>().add(InitiatePayment(
                          amount: double.parse(cartInfo['total']!),
                          userEmail: userEmail,
                          userContact: userContact,
                        ));
                    //PAYMENT PAGE NAVIGATOR
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentPage(),
                      ),
                    );
                  } else {
                    await SummaryRepo().createOrder(
                      cartInfo['vendorId']!,
                      double.parse(cartInfo['total']!),
                      cartInfo['cartId']!,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderProcessingPage(
                          userId: cartInfo['userId']!,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 199, 59),
                ),
                child: Text(
                  state.isOrderAccepted ? 'Proceed to Payment' : 'Proceed',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
