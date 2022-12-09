import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/cart/models/cart.dart';
import 'package:lady_skin/src/features/checkout/repository/checkout_repository.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';

import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutRepository _checkoutRepository = CheckoutRepository();
  Cart cart = Cart(data: [], total: "0", deliveryFee: "0", grandTotal: "0");

  @override
  CheckoutBloc() : super(CheckingOut());

  @override
  Stream<CheckoutState> mapEventToState(CheckoutEvent event) async* {
    if (event is CheckoutStarted) {
      yield CheckingOut();
      try {
        await _checkoutRepository.checkout(addressId: event.addressId);
        yield CheckedOut();
      } catch (e) {
        yield ErrorCheckingOut(error: e);
      }
    }
    if (event is CheckoutWithTransferStarted) {
      yield CheckingOut();
      try {
        final String _imageUrl = await uploadImage(image: event.transferImage);
        await _checkoutRepository.checkoutWithTransfer(
            imageUrl: _imageUrl,
            paymentMethod: event.paymentMethod,
            addressId: event.addressId);
        yield CheckedOut();
      } catch (e) {
        yield ErrorCheckingOut(error: e);
      }
    }
    if (event is BuyNowStarted) {
      yield CheckingOut();
      try {
        await _checkoutRepository.buyNow(
            buyNowItem: event.buyNowItem, addressId: event.addressId);
        yield CheckedOut();
      } catch (e) {
        yield ErrorCheckingOut(error: e);
      }
    }
    if (event is BuyNowWithTransferStarted) {
      yield CheckingOut();
      try {
        final String _imageUrl = await uploadImage(image: event.transferImage);
        await _checkoutRepository.buyNowWithTransfer(
            buyNowItem: event.buyNowItem,
            imageUrl: _imageUrl,
            paymentMethod: event.paymentMethod,
            addressId: event.addressId);
        yield CheckedOut();
      } catch (e) {
        yield ErrorCheckingOut(error: e);
      }
    }
  }
}
