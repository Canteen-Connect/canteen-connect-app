import 'package:email_validator/email_validator.dart';

class Users {
  final String name;
  final String email;
  final String contact;
  final String password;
  final String address;
  final String userId;
  final bool isAdmin;
  final bool isOpen;

  const Users({
    required this.name,
    required this.email,
    required this.contact,
    required this.password,
    required this.address,
    required this.userId,
    this.isAdmin = false,
    this.isOpen = true,
  });

  bool isEmailFromKIETDomain() {
    return email.endsWith("@kiet.edu");
  }

  bool isValid() {
    return name.length >= 2 &&
        EmailValidator.validate(email) &&
        isEmailFromKIETDomain() &&
        contact.length == 10 &&
        password.length >= 8 &&
        address.length >= 5;
  }
}
