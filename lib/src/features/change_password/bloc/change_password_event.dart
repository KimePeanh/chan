import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  ChangePasswordEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  ChangePasswordButtonPressed({
    required this.currentChangePassword,
    required this.newChangePassword,
  });
  final String currentChangePassword;
  final String newChangePassword;
}
