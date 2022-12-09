import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/config/routes/routes.dart';
import 'package:lady_skin/src/features/category/models/category.dart';

Widget categoryTile(
    {required BuildContext context, required Category category}) {
  Random random = new Random();
  int colorIndex = random.nextInt(9);
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, productListByCategory, arguments: category);
    },
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              maxWidthDiskCache: 500,
              maxHeightDiskCache: 500,
              // color: colorList[colorIndex],
              // memCacheHeight: 250,
              // memCacheWidth: 250,
              // fit: BoxFit.cover,
              imageUrl: category.image,
              placeholder: (context, url) => Image.asset(
                  "assets/images/product_placeholder.jpg",
                  fit: BoxFit.fill),
              errorWidget: (context, url, error) => Image.asset(
                  "assets/images/product_placeholder.jpg",
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.15),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.6),
              ],
            )),
            child: Text(
              category.name,
              textScaleFactor: 1.1,
              maxLines: 2,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, productListByCategory, arguments: category);
    },
    child: Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(flex: 10, child: Center()),
                Expanded(
                  flex: 80,
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorList[colorIndex],
                        borderRadius: BorderRadius.circular(100)),
                    //  borderRadius: BorderRadius.circular(100),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Row(
                        children: [
                          Expanded(flex: 15, child: Center()),
                          Expanded(
                            flex: 70,
                            child: CachedNetworkImage(
                                // color: colorList[colorIndex],
                                memCacheHeight: 250,
                                memCacheWidth: 250,
                                fit: BoxFit.fill,
                                imageUrl: category.image,
                                placeholder: (context, url) => Image.asset(
                                    "assets/images/product_placeholder.jpg",
                                    fit: BoxFit.fill),
                                errorWidget: (context, url, error) =>
                                    Container()),
                          ),
                          Expanded(flex: 15, child: Center()),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(flex: 10, child: Center()),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 0.9,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              height: 1.5,
              color: Theme.of(context).textTheme.headline1!.color,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    ),
  );
}

final List<Color?> colorList = [
  Colors.red[50],
  Colors.blue[50],
  Colors.green[50],
  Colors.purple[50],
  Colors.orange[50],
  Colors.yellow[50],
  Colors.pink[50],
  Colors.brown[50],
  Colors.lime[50]
];
