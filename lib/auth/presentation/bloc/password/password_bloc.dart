import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial()) {
    on<ToggleLoginPasswordVisibility>((event, emit) => emit(
        PasswordVisibilityToggled(
            hideLoginPassword: !state.hideLoginPassword,
            hideSignupPassword: state.hideSignupPassword,
            hideConfirmPassword: state.hideConfirmPassword)));

    on<ToggleSignupPasswordVisibility>((event, emit) => emit(
        PasswordVisibilityToggled(
            hideLoginPassword: state.hideLoginPassword,
            hideSignupPassword: !state.hideSignupPassword,
            hideConfirmPassword: state.hideConfirmPassword)));

    on<ToggleConfirmPasswordVisibility>((event, emit) => emit(
        PasswordVisibilityToggled(
            hideLoginPassword: state.hideLoginPassword,
            hideSignupPassword: state.hideSignupPassword,
            hideConfirmPassword: !state.hideConfirmPassword)));
  }
}
