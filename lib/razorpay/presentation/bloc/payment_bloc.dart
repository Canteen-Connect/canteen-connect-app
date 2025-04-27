import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/razorpay/data/repository/data_repo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  late Razorpay _razorpay;
  PaymentBloc() : super(PaymentInitial()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    on<InitiatePayment>(_onInitiatePayment);
    on<PaymentSuccessEvent>(_onPaymentSuccess);
  }

  FutureOr<void> _onInitiatePayment(InitiatePayment event, Emitter<PaymentState> emit) {
    emit(PaymentLoading());
    final options = {
      'key': '',
      'amount': event.amount * 100,
      'currency': 'INR',
      'name': 'Canteen Connect',
      'prefill': {
        'email': event.userEmail,
        'contact': event.userContact,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  FutureOr<void> _onPaymentSuccess(PaymentSuccessEvent event, Emitter<PaymentState> emit) async {
    try {
      final String response = 'success'; //await PaymentDataRepo().createPayment(event.paymentId);
      if (response == 'success') {
        emit(PaymentSuccess());
      } else {
        emit(PaymentFailure('Backend error'));
      }
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    add(PaymentSuccessEvent(paymentId: response.paymentId!));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    emit(PaymentFailure(response.message ?? 'Payment failed'));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
  }

  @override
  Future<void> close() {
    _razorpay.clear();
    return super.close();
  }
}
