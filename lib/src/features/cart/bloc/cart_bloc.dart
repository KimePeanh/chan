import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/cart/models/cart.dart';
import 'package:lady_skin/src/features/cart/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Cart cart = Cart(data: [], total: "0", deliveryFee: "0", grandTotal: "0");
  CartRepository _cartRepository = CartRepository();
  @override
  CartBloc() : super(FetchingCart());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is FetchCart) {
      yield FetchingCart();
      try {
        cart = await _cartRepository.getUserCart(addressId: event.addressId);
        yield FetchedCart();
      } catch (e) {
        yield ErrorFetchingCart(error: e);
      }
    }
    if (event is AddToCart) {
      yield AddingToCart();
      try {
        await _cartRepository.addToCart(
          productId: event.productId,
          variantIdOptionId: event.variantId,
          quantity: event.quantity,
        );
        yield AddedToCart();

        yield FetchingCart();
        cart = await _cartRepository.getUserCart(addressId: null);
        yield FetchedCart();
      } catch (e) {
        print(e.toString());
        yield ErrorCart(error: e);
      }
    }
    if (event is SetQuantity) {
      yield ProccessingCart();
      try {
        await _cartRepository.setQuantity(
            quantity: event.quantity, cartId: event.cartId);
        cart = await _cartRepository.getUserCart(addressId: null);
        yield ProccessedCart();
      } catch (e) {
        yield ErrorCart(error: e);
      }
      yield FetchedCart();
    }
    if (event is LogoutCart) {
      yield FetchingCart();
      cart.data.clear();
      yield FetchedCart();
    }
    // if (event is Increment || event is Decrement) {
    //   yield ProccessingCart();
    //   try {
    //     String tempAccessToken;.
    //     if (event is Increment) {
    //       tempAccessToken = event.accessToken;
    //       await _userCartRepository.incrementOrDecrement(
    //           quantity: event.quantity.toString(),
    //           accessToken: event.accessToken);
    //     }
    //     if (event is Decrement) {
    //       tempAccessToken = event.accessToken;
    //       await _userCartRepository.incrementOrDecrement(
    //           productId: event.productId,
    //           variantId: event.variantId,
    //           quantity: "-" + event.quantity.toString(),
    //           accessToken: event.accessToken);
    //     }
    //     try {
    //       cart = await _userCartRepository.getUserCart(
    //           accessToken: tempAccessToken);
    //       yield ProccessedCart();
    //     } catch (e) {
    //       yield ErrorFetchingCart(error: "e.message");
    //     }
    //   } catch (e) {
    //     yield ErrorCart(error: "e.message");
    //   }
    //   yield FetchedCart();
    // }
    if (event is RemoveFromCart) {
      yield ProccessingCart();
      try {
        await _cartRepository.removeFromCart(cartId: event.cartId);
        cart = await _cartRepository.getUserCart(addressId: null);
        yield ProccessedCart();
      } catch (e) {
        yield ErrorCart(error: e);
      }
      yield FetchedCart();
    }
    // if (event is Checkout) {
    //   yield CheckingOut();
    //   try {
    //     await _cartRepository.checkOut(addressId: event.addressId);
    //     yield CheckedOut();
    //   } catch (e) {
    //     yield ErrorCheckingOut(error: e.toString());
    //   }
    // }
  }
}
