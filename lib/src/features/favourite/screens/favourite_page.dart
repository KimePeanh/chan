import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/favourite/bloc/index.dart';
import 'package:lady_skin/src/utils/helper/helper.dart';
import 'widgets/favourite_product_tile.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavouriteBloc>(context).add(FetchStarted());
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            title: Text(AppLocalizations.of(context)!.translate("favourite"))),
        body: Body());
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (c, s) {
        // Helper.handleState(state: s, context: c);
        if (s is FetchingFavourite) {
          return Center(child: CircularProgressIndicator());
        } else if (s is ErrorFavourite) {
          Helper.handleState(state: s, context: context);
          return Center(child: Text(s.error));
        } else {
          return SingleChildScrollView(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 6,
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemCount:
                  BlocProvider.of<FavouriteBloc>(context).favouriteList.length,
              itemBuilder: (context, index) {
                return FavouriteProductTile(
                    favourite: BlocProvider.of<FavouriteBloc>(context)
                        .favouriteList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
