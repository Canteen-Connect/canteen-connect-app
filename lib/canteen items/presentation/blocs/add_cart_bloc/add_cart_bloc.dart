import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/canteen%20items/data/repository/Item_Repo.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddCartBloc() : super(AddCartInitial()) {
    on<AddToCartEvent>((event, emit) async {
      emit(AddCartLoading());
      final bool message = await ItemRepo().addToCart(event.id, event.productId, event.quantity);
      if (message == true) {
        emit(AddCartSuccess(message: 'Item added to cart successfully'));
      } else {
        emit(AddCartFailure(message: 'Failed to add item to cart'));
      }
    });
  }
}
