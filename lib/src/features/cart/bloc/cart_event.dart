import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  CartEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  AddToCart(
      {required this.productId,
      required this.variantId,
      required this.quantity});

  final String productId;
  final String? variantId;
  final int quantity;
}

// class Increment extends CartEvent {
//   Increment(
//       {required this.cartId,
//       required this.quantity,
//       required this.accessToken});

//   final String cartId;
//   final int quantity;
//   final String accessToken;
// }
class SetQuantity extends CartEvent {
  SetQuantity({
    required this.cartId,
    required this.quantity,
  });

  final String cartId;
  final int quantity;
}
// class Decrement extends CartEvent {
//   Decrement(
//       {required this.cartId,
//       required this.quantity,
//       required this.accessToken});

//   final String cartId;
//   final int quantity;
//   final String accessToken;
// }

class RemoveFromCart extends CartEvent {
  RemoveFromCart({required this.cartId});

  final String cartId;
}

// ignore: must_be_immutable
class FetchCart extends CartEvent {
  String? addressId;
  // ignore: avoid_init_to_null
  FetchCart({this.addressId = null});
}

class LogoutCart extends CartEvent {}
