import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/shipping_address/models/address.dart';
import 'package:lady_skin/src/features/shipping_address/repositories/shipping_address_repository.dart';
import 'shipping_address_state.dart';
import 'shipping_address_event.dart';

class ShippingAddressBloc
    extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  List<Address> addressList = [];
  ShippingAddressRepository _userAddressRepository =
      ShippingAddressRepository();
  @override
  ShippingAddressBloc() : super(FetchingAddressList());

  @override
  Stream<ShippingAddressState> mapEventToState(
      ShippingAddressEvent event) async* {
    if (event is FetchAddressListStarted) {
      yield FetchingAddressList();
      try {
        addressList = await _userAddressRepository.getUserAddresses();
        yield FetchedAddressList();
      } catch (e) {
        yield ErrorFetchingAddressList(error: e);
      }
    }

    if (event is AddAddressStarted) {
      yield ProcessingAddress();
      try {
        await _userAddressRepository.addUserAddress(
            description: event.description,
            lat: event.lat,
            long: event.long,
            name: "a");
        addressList = await _userAddressRepository.getUserAddresses();
        yield ProcessedAddress();
      } catch (e) {
        yield ErrorProcessingAddress(error: e);
      }
    }
    if (event is RemoveAddressStarted) {
      yield ProcessingAddress();
      try {
        await _userAddressRepository.removeUserAddress(
            addressId: event.address.id);
        addressList = await _userAddressRepository.getUserAddresses();
        yield ProcessedAddress();
      } catch (e) {
        yield ErrorProcessingAddress(error: e);
      }
    }
    if (event is SetDefaultAddress) {
      yield ProcessingAddress();
      try {
        await _userAddressRepository.setDefaultAddresses(
            addressId: event.address.id);
        addressList = await _userAddressRepository.getUserAddresses();
        yield SetDefaultAddressSucess(address: event.address);
        yield ProcessedAddress();
      } catch (e) {
        yield ErrorProcessingAddress(error: e);
      }
    }
  }
}
