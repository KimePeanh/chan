import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';

abstract class CheckoutState extends Equatable {
  CheckoutState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class CheckingOut extends CheckoutState {}

class CheckedOut extends CheckoutState {}

class ErrorCheckingOut extends CheckoutState with ErrorState {
  ErrorCheckingOut({required this.error});
  final dynamic error;
}
