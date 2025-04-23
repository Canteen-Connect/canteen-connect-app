part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

final class InitiatePayment extends PaymentEvent {
  final double amount;
  final String userEmail;
  final String userContact;

  InitiatePayment({
    required this.amount,
    required this.userEmail,
    required this.userContact,
  });
}

final class PaymentSuccessEvent extends PaymentEvent {
  final String paymentId;

  PaymentSuccessEvent({
    required this.paymentId,
  });
}
