import 'package:email_validator/email_validator.dart';
import 'package:foodies/MONGODB/mongo.dart';
import 'package:foodies/Models/user.dart';
import 'package:foodies/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:realm/realm.dart';

class AuthMethods {
  final appConfig = AppConfiguration(APP_ID);
  late final app = App(appConfig);

  Future<String> signUp(String name, String email, String contact,
      String password, String repass, String address) async {
    String res = "";
    try {
      if (name.length >= 2 &&
          EmailValidator.validate(email) &&
          email.endsWith("@kiet.edu") &&
          contact.length == 10 &&
          password.length >= 8 &&
          address.length >= 5 &&
          repass == password) {
        // Create a new user in Realm App (MongoDB Atlas
        EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
        await authProvider.registerUser(email, password);
        // Create a new user document in MongoDB Atlas
        await app.logIn(Credentials.emailPassword(email, password));
        Users user = Users(
          name: name,
          email: email,
          contact: contact,
          password: password,
          address: address,
          userId: app.currentUser!.id,
        );
        var db = await Db.create(MONGO_URL);
        await db.open();
        await db.collection("users").insertOne({
          "_id": app.currentUser!.id,
          "name": user.name,
          "email": user.email,
          "contact": user.contact,
          "password": user.password,
          "address": user.address,
          "isAdmin": user.isAdmin,
          "isOpen": user.isOpen,
        });
        res = "success";
        print("User registered successfully!");
      } else {
        res = "Invalid user details";
        print("Invalid user details");
      }
    } catch (e) {
      res = "Failed to register user: $e";
      print("Failed to register user: $e");
    }
    return res;
  }

  Future<String> loginUser(String email, String password) async {
    String res = "";
    try {
      await app.logIn(Credentials.emailPassword(email, password));
      res = "success";
      print("User logged in successfully! :" + app.currentUser!.id);
    } catch (e) {
      res = "Failed to log in user: $e";
      print("Failed to log in user: $e");
    }
    return res;
  }
}
