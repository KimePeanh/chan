import 'package:lady_skin/src/features/shipping_address/models/address.dart';
import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ShippingAddressState extends Equatable {
  ShippingAddressState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingAddressList extends ShippingAddressState {
  @override
  String toString() => 'FetchingAddresses';
}

class FetchedAddressList extends ShippingAddressState {}

class ProcessingAddress extends ShippingAddressState {}

class ProcessedAddress extends ShippingAddressState {}

class ErrorFetchingAddressList extends ShippingAddressState with ErrorState {
  ErrorFetchingAddressList({required this.error});
  final dynamic error;
}

class ErrorProcessingAddress extends ShippingAddressState with ErrorState {
  ErrorProcessingAddress({required this.error});
  final dynamic error;
}

class SetDefaultAddressSucess extends ShippingAddressState {
  final Address address;
  SetDefaultAddressSucess({required this.address});
}
