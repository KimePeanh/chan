import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/buy_now/repositories/buy_now_repository.dart';
import 'package:lady_skin/src/features/cart/models/cart.dart';

import 'buy_now_event.dart';
import 'buy_now_state.dart';

class BuyNowBloc extends Bloc<BuyNowEvent, BuyNowState> {
  BuyNowRepository _buyNowRepository = BuyNowRepository();
  @override
  BuyNowBloc() : super(FetchingBuyNow());

  @override
  Stream<BuyNowState> mapEventToState(BuyNowEvent event) async* {
    if (event is FetchBuyNow) {
      yield FetchingBuyNow();
      try {
        Cart tempCart = await _buyNowRepository.getBuyNowCart(
            buyNowItem: event.buyNowItem, addressId: event.addressId);
        yield FetchedBuyNow(cart: tempCart);
      } catch (e) {
        yield ErrorFetchingBuyNow(error: e);
      }
    }
  }
}
