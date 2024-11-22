part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetCart extends CartEvent {}

final class UpdateCart extends CartEvent {
  final String productId;
  final String quantity;

  UpdateCart(this.productId, this.quantity);
}

final class DeleteProduct extends CartEvent {
  final String productId;

  DeleteProduct(this.productId);
}
