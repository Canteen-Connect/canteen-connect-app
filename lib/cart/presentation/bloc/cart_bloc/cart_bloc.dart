import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/canteen%20items/presentation/model/Item.dart';
import 'package:foodies/cart/data/repository/cart_repo.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetCart>((event, emit) async {
      emit(CartLoading());
      try {
        final Map<String, dynamic> cart = await CartRepo().getCart();
        emit(CartLoaded(cart['cartItems'], cart['totalPrice']));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<UpdateCart>((event, emit) async {
      try {
        await CartRepo().updateCart(event.productId, event.quantity);
        emit(CartLoading());
        final Map<String, dynamic> cart = await CartRepo().getCart();
        emit(CartLoaded(cart['cartItems'], cart['totalPrice']));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) async {
      try {
        await CartRepo().deleteProduct(event.productId);
        emit(CartLoading());
        final Map<String, dynamic> cart = await CartRepo().getCart();
        print(cart['cartItems']);
        emit(CartLoaded(cart['cartItems'], cart['totalPrice']));
      } catch (e) {
        emit(CartError('Something went wrong'));
      }
    });
  }
}
