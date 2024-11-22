part of 'item_bloc.dart';

@immutable
sealed class ItemEvent {}

final class FetchItems extends ItemEvent {
  final String id;

  FetchItems(this.id);
}
