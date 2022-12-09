import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class MyOrderState extends Equatable {
  MyOrderState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingOrder extends MyOrderState {}

class FetchedOrder extends MyOrderState {}

class ErrorFetchingOrder extends MyOrderState with ErrorState {
  ErrorFetchingOrder({required this.error});
  final dynamic error;
}

class PayingOrder extends MyOrderState {}

class PaidOrder extends MyOrderState {}

class ErrorPayingOrder extends MyOrderState with ErrorState {
  ErrorPayingOrder({required this.error});
  final dynamic error;
}
