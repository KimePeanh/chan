import 'dart:io';

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class MyOrderEvent extends Equatable {
  MyOrderEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchMyOrder extends MyOrderEvent {}

class FetchMyOrderDetail extends MyOrderEvent {
  final String orderId;
  FetchMyOrderDetail({required this.orderId});
}

class PayOrder extends MyOrderEvent {
  final String paymentMethod;
  final String orderId;
  final File transactionImage;
  PayOrder(
      {required this.orderId,
      required this.transactionImage,
      required this.paymentMethod});
}
