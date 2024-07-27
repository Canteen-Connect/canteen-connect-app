import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<PageChanged>((event, emit) {
      emit(PageLoading());
      try {
        emit(PageLoaded(page: event.page));
      } catch (e) {
        emit(PageError(message: e.toString()));
      }
    });
  }
}
