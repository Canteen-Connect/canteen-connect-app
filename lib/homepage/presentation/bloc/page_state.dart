part of 'page_bloc.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {
  final int page = 0;
}

final class PageLoading extends PageState {}

final class PageLoaded extends PageState {
  final int page;
  PageLoaded({required this.page});
}

final class PageError extends PageState {
  final String message;
  PageError({required this.message});
}
