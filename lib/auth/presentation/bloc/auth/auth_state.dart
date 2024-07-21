part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignInSuccess extends AuthState {
  final String token;

  AuthSignInSuccess({required this.token});
}

final class AuthError extends AuthState {
  final String error;

  AuthError({required this.error});
}

final class AuthSignUpSuccess extends AuthState {}

final class AuthSignOutSuccess extends AuthState {}
