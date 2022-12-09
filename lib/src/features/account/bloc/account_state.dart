import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/account/models/user.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

// ignore: must_be_immutable
abstract class AccountState extends Equatable {
  User? user;
  AccountState(this.user) : super();
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchingAccount extends AccountState {
  FetchingAccount() : super(null);
}

// ignore: must_be_immutable
class FetchedAccount extends AccountState {
  final User user;
  FetchedAccount({required this.user}) : super(user);
}

// ignore: must_be_immutable
class ErrorFetchingAccount extends AccountState with ErrorState {
  final dynamic error;
  ErrorFetchingAccount({required this.error}) : super(null);
}

// ignore: must_be_immutable
class ErrorUpdatingAccount extends AccountState with ErrorState {
  final dynamic error;
  ErrorUpdatingAccount({required this.error}) : super(null);
}

// ignore: must_be_immutable
class UpdatingAccount extends AccountState {
  UpdatingAccount() : super(null);
}

// ignore: must_be_immutable
class UpdatedAccount extends AccountState {
  UpdatedAccount() : super(null);
}
