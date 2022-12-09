import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/favourite/bloc/index.dart';
import 'package:lady_skin/src/features/product/models/product.dart';

class FavouriteButton extends StatefulWidget {
  final Product product;
  FavouriteButton({required this.product});
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  late FavouriteBloc _favouriteBloc;
  @override
  void initState() {
    _favouriteBloc = FavouriteBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _favouriteBloc,
        builder: (c, s) {
          if (s is FetchingFavourite || s is ErrorFavourite) {
            return IconButton(
              icon: Icon(Icons.favorite_outline),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _favouriteBloc.add(AddToFavourite(product: widget.product));
              },
            );
          } else if (s is AddingToFavourite) {
            return Center(child: CircularProgressIndicator());
          } else {
            return IconButton(
              icon: Icon(Icons.favorite),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            );
          }
        });
  }
}
