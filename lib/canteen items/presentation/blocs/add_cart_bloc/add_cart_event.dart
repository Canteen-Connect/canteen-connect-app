part of 'add_cart_bloc.dart';

@immutable
sealed class AddCartEvent {}

class AddToCartEvent extends AddCartEvent {
  final String id;
  final String productId;
  final String quantity;

  AddToCartEvent({
    required this.id,
    required this.productId,
    required this.quantity,
  });
}
