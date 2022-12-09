import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lady_skin/src/features/favourite/models/favourite.dart';
import 'package:lady_skin/src/features/favourite/repository/favourite_repository.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<Favourite> favouriteList = [];
  FavouriteRepository _favouriteRepository = FavouriteRepository();
  @override
  FavouriteBloc() : super(FetchingFavourite());

  @override
  Stream<FavouriteState> mapEventToState(FavouriteEvent event) async* {
    if (event is AddToFavourite) {
      yield AddingToFavourite(event.product.id);
      try {
        await _favouriteRepository.addToFavourite(productId: event.product.id);

        favouriteList = await _favouriteRepository.getUserFavourite();
        yield AddedToFavourite();
      } catch (e) {
        yield ErrorFavourite(error: e);
      }
    }
    if (event is FetchStarted) {
      yield FetchingFavourite();
      try {
        favouriteList = await _favouriteRepository.getUserFavourite();
        yield FetchedFavourite();
      } catch (e) {
        yield ErrorFavourite(error: e);
      }
    }
    if (event is RemoveFromFavourite) {
      yield RemovingFromFavourite();
      try {
        await _favouriteRepository.removeFromFavourite(
            favouriteId: event.favourite.id);
        favouriteList.remove(event.favourite);
        yield FetchedFavourite();
      } catch (e) {
        yield ErrorFavourite(error: e);
      }
    }
  }
}
