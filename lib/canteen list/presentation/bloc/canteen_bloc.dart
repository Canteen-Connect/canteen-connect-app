import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/canteen%20list/data/repository/canteen_repo.dart';
import 'package:foodies/canteen%20list/presentation/model/canteen_model.dart';

part 'canteen_event.dart';
part 'canteen_state.dart';

class CanteenBloc extends Bloc<CanteenEvent, CanteenState> {
  CanteenBloc() : super(CanteenInitial()) {
    on<FetchCanteenList>((event, emit) async {
      emit(CanteenLoading());
      try {
        final List<Canteen> canteenList = await CanteenRepo().getCanteenList();
        emit(CanteenLoaded(canteenList));
      } catch (e) {
        emit(CanteenError(e.toString()));
      }
    });
  }
}
