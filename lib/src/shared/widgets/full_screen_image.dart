import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear),
        ),
      ),
      body: Center(
        child: PinchZoom(
          child: Hero(
            tag: imageUrl,
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fitWidth,
              placeholder: "assets/images/product_placeholder.jpg",
              image: imageUrl,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container();
              },
            ),
            // ExtendedImage.network(imageUrl,
            //     errorWidget: Image.asset("assets/images/product_placeholder.jpg"),
            //     enableMemoryCache: true,
            //     clearMemoryCacheWhenDispose: true,
            //     clearMemoryCacheIfFailed: false,
            //     fit: BoxFit.fitWidth,
            //     cache: true,
            //     width: 800,
            //     cacheHeight: 800),
          ),
        ),
      ),
    );
  }
}
