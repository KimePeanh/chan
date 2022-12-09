import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class Initializing extends LoginState {}

class Logged extends LoginState {
  final String token;
  Logged({required this.token});
}

class Logging extends LoginState {}

class ErrorLogin extends LoginState {
  final String error;
  ErrorLogin({required this.error});
}
