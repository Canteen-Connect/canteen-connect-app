part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<Item> cartItems;
  final int totalPrice;

  CartLoaded(this.cartItems, this.totalPrice);
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}
