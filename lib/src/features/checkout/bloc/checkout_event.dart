import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/buy_now/models/buy_now_item.dart';

abstract class CheckoutEvent extends Equatable {
  CheckoutEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class CheckoutStarted extends CheckoutEvent {
  CheckoutStarted({required this.addressId});
  final String addressId;
}

class CheckoutWithTransferStarted extends CheckoutEvent {
  CheckoutWithTransferStarted(
      {required this.addressId,
      required this.transferImage,
      required this.paymentMethod});
  final String addressId;
  final File transferImage;
  final String paymentMethod;
}

class BuyNowStarted extends CheckoutEvent {
  BuyNowStarted({required this.addressId, required this.buyNowItem});
  final String addressId;
  final BuyNowItem buyNowItem;
}

class BuyNowWithTransferStarted extends CheckoutEvent {
  BuyNowWithTransferStarted(
      {required this.addressId,
      required this.transferImage,
      required this.paymentMethod,
      required this.buyNowItem});
  final String addressId;
  final File transferImage;
  final String paymentMethod;
  final BuyNowItem buyNowItem;
}
