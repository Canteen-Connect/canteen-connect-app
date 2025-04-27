import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/canteen%20items/presentation/model/Item.dart';
import 'package:foodies/checkout/data/repository/summary_repo.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc() : super(SummaryInitial()) {
    on<GetSummary>((event, emit) async {
      emit(SummaryLoading());
      try {
        final Map<String, dynamic> cart = await SummaryRepo().getCart();
        emit(SummaryLoaded(cart['cartItems'], cart['totalPrice'], false, false));
      } catch (e) {
        emit(SummaryError(e.toString()));
      }
    });

    on<OrderAccepted>((event, emit) async {
      emit(SummaryLoading());
      try {
        final Map<String, dynamic> cart = await SummaryRepo().getCart();
        emit(SummaryLoaded(cart['cartItems'], cart['totalPrice'], true, true));
      } catch (e) {
        emit(SummaryError(e.toString()));
      }
    });
  }
}
