part of 'password_bloc.dart';

@immutable
sealed class PasswordEvent {}

class ToggleLoginPasswordVisibility extends PasswordEvent {}

class ToggleSignupPasswordVisibility extends PasswordEvent {}

class ToggleConfirmPasswordVisibility extends PasswordEvent {}
