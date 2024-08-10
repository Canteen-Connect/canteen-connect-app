part of 'canteen_bloc.dart';

@immutable
sealed class CanteenState {}

final class CanteenInitial extends CanteenState {}

final class CanteenLoading extends CanteenState {}

final class CanteenLoaded extends CanteenState {
  final List<Canteen> canteenList;

  CanteenLoaded(this.canteenList);
}

final class CanteenError extends CanteenState {
  final String message;

  CanteenError(this.message);
}
