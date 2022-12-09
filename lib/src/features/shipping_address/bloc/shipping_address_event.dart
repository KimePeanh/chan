import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/shipping_address/models/address.dart';

abstract class ShippingAddressEvent extends Equatable {
  ShippingAddressEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchAddressListStarted extends ShippingAddressEvent {}

class AddAddressStarted extends ShippingAddressEvent {
  AddAddressStarted(
      {required this.name,
      required this.lat,
      required this.long,
      required this.description});
  final String name;
  final String lat;
  final String long;
  final String description;
}

class RemoveAddressStarted extends ShippingAddressEvent {
  final Address address;
  RemoveAddressStarted({required this.address});
}

class SetDefaultAddress extends ShippingAddressEvent {
  final Address address;
  SetDefaultAddress({required this.address});
}
