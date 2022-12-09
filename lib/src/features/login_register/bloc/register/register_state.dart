import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class Initializing extends RegisterState {}

class Registered extends RegisterState {
  final String token;
  Registered({required this.token});
}

class Registering extends RegisterState {}

class ErrorRegistering extends RegisterState {
  final String error;
  ErrorRegistering({required this.error});
}
