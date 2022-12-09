import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/authentication/repositories/authentication_repository.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// {@macro counter_bloc}
  AuthenticationBloc() : super(Initializing());
  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is CheckingAuthenticationStarted) {
      yield Initializing();
      await Future.delayed(Duration(milliseconds: 1100));
      String? _token = await _authenticationRepository.getToken();
      if (_token == null) {
        yield NotAuthenticated();
      } else {
        ApiProvider.accessToken = _token;

        yield Authenticated(token: _token);
      }
    }
    if (event is AuthenticationStarted) {
      yield Authenticating();
      await _authenticationRepository.saveToken(token: event.token);
      ApiProvider.accessToken = event.token;
      yield Authenticated(token: event.token);
    }
    if (event is LogoutPressed) {
      yield Authenticating();
      await _authenticationRepository.removeToken();
      ApiProvider.accessToken = "";
      yield NotAuthenticated();
    }
  }
}
