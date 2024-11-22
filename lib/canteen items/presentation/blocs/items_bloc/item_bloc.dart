import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/canteen%20items/data/repository/Item_Repo.dart';
import 'package:foodies/canteen%20items/presentation/model/Item.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on(<FetchItem>(event, emit) async {
      emit(ItemLoading());
      try {
        final List<Item> itemList = await ItemRepo().getItemList(event.id);
        emit(ItemLoaded(itemList));
      } catch (e) {
        emit(ItemError(e.toString()));
      }
    });
  }
}
