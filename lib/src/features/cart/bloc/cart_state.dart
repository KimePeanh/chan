import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class CartState extends Equatable {
  CartState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class AddingToCart extends CartState {}

class AddedToCart extends CartState {}

class ProccessingCart extends CartState {}

class ProccessedCart extends CartState {}

class ErrorCart extends CartState with ErrorState {
  ErrorCart({required this.error});
  final dynamic error;
}

class FetchingCart extends CartState {}

class FetchedCart extends CartState {}

class ErrorFetchingCart extends CartState with ErrorState {
  ErrorFetchingCart({required this.error});
  final dynamic error;
}

class CheckingOut extends CartState {}

class CheckedOut extends CartState {}

// class ErrorCheckingOut extends CartState {
//   ErrorCheckingOut({required this.error});
//   final String error;
// }
