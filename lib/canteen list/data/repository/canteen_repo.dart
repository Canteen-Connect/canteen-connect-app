import 'dart:convert';
import 'package:foodies/canteen%20list/data/provider/canteen_provider.dart';
import 'package:foodies/canteen%20list/presentation/model/canteen_model.dart';

class CanteenRepo {
  Future<List<Canteen>> getCanteenList() async {
    final response = await CanteenProvider().getCanteenList();
    if (response.isRight) {
      final List<Canteen> canteenList = [];
      final List<dynamic> data = jsonDecode(response.right.body)['data'];
      for (var element in data) {
        canteenList.add(
          Canteen(
            id: element['_id'].toString(),
            name: element['name'].toString(),
            email: element['email'].toString(),
            image: ''.toString(),
            description: ''.toString(),
            isOpen: element['isOpen'].toString() == 'true' ? true : false,
          ),
        );
      }
      return canteenList;
    } else {
      throw response.left;
    }
  }
}
