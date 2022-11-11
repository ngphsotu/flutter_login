import 'package:flutter_bloc/flutter_bloc.dart';

import '../form_submission_status.dart';
import '/auth/auth_repository.dart';
import '/auth/login/login_event.dart';
import '/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  // LoginBloc({required this.authRepo}) : super(LoginState());

  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.login();
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    }
  }

  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   // Username updated
  //   if (event is LoginUsernameChanged) {
  //     yield state.copyWith(username: event.username);

  //     // Password updated
  //   } else if (event is LoginPasswordChanged) {
  //     yield state.copyWith(password: event.password);

  //     // Form submitted
  //   } else if (event is LoginSubmitted) {
  //     yield state.copyWith(formStatus: FormSubmitting());

  //     try {
  //       await authRepo.login();
  //       yield state.copyWith(formStatus: SubmissionSuccess());
  //     } on Exception catch (e) {
  //       yield state.copyWith(formStatus: SubmissionFailed(e));
  //     }
  //   }
  // }
}
