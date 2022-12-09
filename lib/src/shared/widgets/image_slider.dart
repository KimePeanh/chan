import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'full_screen_image.dart';

class ImageSlider extends StatefulWidget {
  final BoxFit fit;
  final double aspectRatio;
  final int duration;
  final List images;
  final bool autoPlay;
  final bool showDot;
  final bool willCache;
  const ImageSlider(
      {required this.aspectRatio,
      required this.fit,
      required this.duration,
      required this.images,
      required this.autoPlay,
      required this.showDot,
      required this.willCache});

  @override
  _FrameState createState() => _FrameState();
}

class _FrameState extends State<ImageSlider> {
  int current = 0;
  List<T> ma<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
            autoPlayAnimationDuration: Duration(milliseconds: widget.duration),
            autoPlayCurve: Curves.fastOutSlowIn,
            aspectRatio: widget.aspectRatio,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: widget.autoPlay,
          ),
          items: widget.images
              .map<Widget>((image) => Builder(
                  builder: (BuildContext context) => Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(0),
                        child: (widget.willCache)
                            ? CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: image,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Container())
                            : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreenImage(
                                              imageUrl: image,
                                            )),
                                  );
                                },
                                child: Hero(
                                  tag: image,
                                  child: FadeInImage.assetNetwork(
                                    imageCacheHeight: 800,
                                    imageCacheWidth: 800,
                                    fit: widget.fit,
                                    placeholder:
                                        "assets/images/product_placeholder.jpg",
                                    image: image,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      print(error);
                                      return Container();
                                    },
                                  ),
                                  // ExtendedImage.network(image,
                                  //     errorWidget: Image.asset(
                                  //         "assets/images/product_placeholder.jpg"),
                                  //     enableMemoryCache: true,
                                  //     clearMemoryCacheWhenDispose: true,
                                  //     clearMemoryCacheIfFailed: false,
                                  //     fit: BoxFit.cover,
                                  //     cache: true,
                                  //     width: 800,
                                  //     cacheHeight: 800),
                                ),
                              ),
                        decoration: BoxDecoration(
                          // image: DecorationImage(
                          //     image: NetworkImage(image), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      )))
              .toList(),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (widget.showDot)
                ? ma<Widget>(widget.images, (index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      width: current == index ? 8 : 5,
                      height: current == index ? 8 : 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                      // child: current == index ? Text("$current/${widget.images.length}") : 5,,
                    );
                  })
                : [
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "${current + 1}",
                          textScaleFactor: 1.2,
                        )),
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text("/${widget.images.length}"))
                  ])
      ],
    );
  }
}
