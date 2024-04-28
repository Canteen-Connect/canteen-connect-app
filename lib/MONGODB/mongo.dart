import 'dart:developer';

import 'package:foodies/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart';

class MongoDatabase {
  var db;
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection("users");
    print(await collection.find().toList());
    final appConfig = AppConfiguration(APP_ID);
    final app = App(appConfig);
  }
}
