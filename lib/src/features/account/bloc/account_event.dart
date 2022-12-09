import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/account/models/user.dart';

abstract class AccountEvent extends Equatable {
  AccountEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchAccountStarted extends AccountEvent {}

class SetAccount extends AccountEvent {
  final User user;
  SetAccount({required this.user});
}

class UpdateAccount extends AccountEvent {
  final File? imageFile;
  final User user;
  UpdateAccount({required this.user, required this.imageFile});
}
