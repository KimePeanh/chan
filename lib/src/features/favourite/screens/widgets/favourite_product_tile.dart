import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lady_skin/src/features/favourite/bloc/index.dart';
import 'package:lady_skin/src/features/favourite/models/favourite.dart';
import 'package:lady_skin/src/features/product/screens/product_detail_page.dart';

class FavouriteProductTile extends StatelessWidget {
  FavouriteProductTile({required this.favourite});
  final Favourite favourite;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 0,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: favourite.product)));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                    ),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: "assets/images/product_placeholder.jpg",
                      image: favourite.product.thumbnail,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Opacity(
                          opacity: 0.2,
                          child: Image.asset(
                              "assets/images/product_placeholder.jpg"),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        BlocProvider.of<FavouriteBloc>(context)
                            .add(RemoveFromFavourite(favourite: favourite));
                      },
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 25,
            child: Container(
              margin: EdgeInsets.all(5),
              //color: Colors.grey,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${favourite.product.name}",
                  maxLines: 2,
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
              //color: Colors.pink,
              child: Row(
                children: [
                  Expanded(
                    flex: 65,
                    child: Container(
                      //color: Colors.black,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${favourite.product.price}",
                          maxLines: 2,
                          style: TextStyle(
                              letterSpacing: 1, color: Colors.red[300]),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 35,
                    child: Container(
                      //color: Colors.black,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          children: [
                            Expanded(flex: 45, child: Container()),
                            Expanded(
                              flex: 10,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
