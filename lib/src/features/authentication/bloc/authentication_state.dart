import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  final String? token;
  @override
  List<Object> get props => [];
  AuthenticationState({required this.token});
}

class Initializing extends AuthenticationState {
  Initializing() : super(token: null);
}

class Authenticated extends AuthenticationState {
  final String token;
  Authenticated({required this.token}) : super(token: token);
}

class Authenticating extends AuthenticationState {
  Authenticating() : super(token: null);
}

class NotAuthenticated extends AuthenticationState {
  NotAuthenticated() : super(token: null);
}

class ErrorAuthentication extends AuthenticationState {
  ErrorAuthentication({required this.error}) : super(token: null);
  final String error;
}
