import 'package:equatable/equatable.dart';
import 'package:lady_skin/src/features/favourite/models/favourite.dart';
import 'package:lady_skin/src/features/product/models/product.dart';

abstract class FavouriteEvent extends Equatable {
  FavouriteEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class AddToFavourite extends FavouriteEvent {
  AddToFavourite({required this.product});

  final Product product;

  @override
  String toString() => 'add to favourite';
}

class RemoveFromFavourite extends FavouriteEvent {
  RemoveFromFavourite({required this.favourite});
  final Favourite favourite;
  @override
  String toString() => "remove from favourite";
}

class FetchStarted extends FavouriteEvent {
  FetchStarted();
  @override
  String toString() => 'favourite initialize';
}
