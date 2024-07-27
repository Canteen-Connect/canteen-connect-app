part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}

class SignUpWithEmailAndPassword extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;

  SignUpWithEmailAndPassword({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });
}

class LogOut extends AuthEvent {}

class TokenValidation extends AuthEvent {}

class AuthEventError extends AuthEvent {
  final String error;

  AuthEventError({required this.error});
}
