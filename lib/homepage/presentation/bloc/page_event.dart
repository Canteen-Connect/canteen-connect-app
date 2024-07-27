part of 'page_bloc.dart';

@immutable
sealed class PageEvent {}

final class PageChanged extends PageEvent {
  final int page;
  PageChanged({required this.page});
}
