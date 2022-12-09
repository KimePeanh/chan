import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckingAuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {
  final String token;
  AuthenticationStarted({required this.token});
}

class LogoutPressed extends AuthenticationEvent {}
