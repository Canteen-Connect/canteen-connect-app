part of 'password_bloc.dart';

@immutable
sealed class PasswordState {
  final bool hideLoginPassword;
  final bool hideSignupPassword;
  final bool hideConfirmPassword;

  PasswordState(
      {required this.hideLoginPassword,
      required this.hideSignupPassword,
      required this.hideConfirmPassword});
}

final class PasswordInitial extends PasswordState {
  PasswordInitial()
      : super(
            hideLoginPassword: true,
            hideSignupPassword: true,
            hideConfirmPassword: true);
}

final class PasswordVisibilityToggled extends PasswordState {
  PasswordVisibilityToggled(
      {required bool hideLoginPassword,
      required bool hideSignupPassword,
      required bool hideConfirmPassword})
      : super(
            hideLoginPassword: hideLoginPassword,
            hideSignupPassword: hideSignupPassword,
            hideConfirmPassword: hideConfirmPassword);
}
