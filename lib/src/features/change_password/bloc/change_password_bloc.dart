import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/change_password/repositories/change_password_repository.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangeChangePasswordRepository _userAccountRepository =
      ChangeChangePasswordRepository();
  @override
  ChangePasswordBloc() : super(Initializing());

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangePasswordButtonPressed) {
      yield Changing();
      try {
        await Future.delayed(Duration(milliseconds: 500));
        final String accessToken =
            await _userAccountRepository.changeChangePassword(
          currentChangePassword: event.currentChangePassword,
          newChangePassword: event.newChangePassword,
        );
        yield Changed(accessToken: accessToken);
      } catch (e) {
        yield ChangeFailed(error: e);
      }
    }
  }
}
