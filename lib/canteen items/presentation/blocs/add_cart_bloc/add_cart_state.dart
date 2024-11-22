part of 'add_cart_bloc.dart';

@immutable
sealed class AddCartState {}

final class AddCartInitial extends AddCartState {}

final class AddCartLoading extends AddCartState {}

final class AddCartSuccess extends AddCartState {
  final String message;

  AddCartSuccess({
    required this.message,
  });
}

final class AddCartFailure extends AddCartState {
  final String message;

  AddCartFailure({
    required this.message,
  });
}
