part of 'summary_bloc.dart';

@immutable
sealed class SummaryState {}

final class SummaryInitial extends SummaryState {}

final class SummaryLoading extends SummaryState {}

final class SummaryLoaded extends SummaryState {
  final List<Item> items;
  final int totalPrice;
  final bool isOrderProcessing;
  final bool isOrderAccepted;
  SummaryLoaded(this.items, this.totalPrice, this.isOrderProcessing, this.isOrderAccepted);
}

final class SummaryError extends SummaryState {
  final String message;

  SummaryError(this.message);
}
