import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class RegisterPressed extends RegisterEvent {
  final String name;
  final String phoneNumber;
  final String password;
  RegisterPressed(
      {required this.name, required this.phoneNumber, required this.password});
}
