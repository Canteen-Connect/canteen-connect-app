import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:foodies/auth/data/repository/auth_repo.dart';
import 'package:foodies/core/api/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInWithEmailAndPassword>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final response = await AuthRepo()
              .signInWithEmailAndPassword(event.email, event.password);
          if (response[UserApi.success] == true) {
            final token = response[UserApi.token];
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
            emit(AuthSignInSuccess(token: response[UserApi.token]));
          } else {
            emit(AuthError(error: response[UserApi.message]));
          }
        } catch (e) {
          emit(AuthError(error: e.toString()));
        }
      },
    );

    on<SignUpWithEmailAndPassword>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final response = await AuthRepo().signUpWithEmailAndPassword(
            event.name,
            event.email,
            event.phone,
            event.password,
            event.address,
          );
          if (response[UserApi.success] == true) {
            emit(AuthSignUpSuccess());
          } else {
            emit(AuthError(error: response[UserApi.message]));
          }
        } catch (e) {
          emit(AuthError(error: e.toString()));
        }
      },
    );

    on<LogOut>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          emit(AuthSignOutSuccess());
        } catch (e) {
          emit(AuthError(error: 'Failed to log out : $e'));
        }
      },
    );
  }
}
