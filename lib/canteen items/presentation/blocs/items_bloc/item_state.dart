part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemLoaded extends ItemState {
  final List<Item> itemList;

  ItemLoaded(this.itemList);
}

final class ItemError extends ItemState {
  final String message;

  ItemError(this.message);
}
