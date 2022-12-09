import 'package:lady_skin/src/utils/constants/app_constant.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class FavouriteState extends Equatable {
  FavouriteState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class LoadingFavourite extends FavouriteState {}

class AddingToFavourite extends FavouriteState {
  AddingToFavourite(this.productId);
  final String productId;
}

class AddedToFavourite extends FavouriteState {}

class RemovingFromFavourite extends FavouriteState {}

class RemovedFromFavourite extends FavouriteState {}

class FetchingFavourite extends FavouriteState {}

class FetchedFavourite extends FavouriteState {}

class ErrorFetchingFavouite extends FavouriteState with ErrorState {
  ErrorFetchingFavouite({required this.error});
  final dynamic error;
}

class ErrorFavourite extends FavouriteState with ErrorState {
  ErrorFavourite({required this.error});
  final dynamic error;
}

// class SucceedFavourite extends FavouriteState with ErrorState {}

class FavouriteEmpty extends FavouriteState {}
