import 'dart:developer';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lady_skin/src/features/blog/models/blog.dart';
import 'package:lady_skin/src/features/blog/screens/blog_detail_page.dart';
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogTile extends StatelessWidget {
  final Blog blog;
  BlogTile({required this.blog});

  @override
  Widget build(BuildContext context) {
    var document = parse(blog.content);
    var elements = document.getElementsByTagName("p");
    int? paragraphIndex;
    for (int i = 0; i < elements.length; i++) {
      if (elements[i].children.length == 0) {
        paragraphIndex = i;
        break;
      } else {
        // log(elements[i].children[0].innerHtml);
        // log(elements[i].innerHtml.);
      }
    }
    return GestureDetector(
      onTap: () {
        if (blog.content.split("fbwatch").length == 3) {
          if (Platform.isIOS) {
            launch(blog.content.split("fbwatch")[1],
                forceSafariVC: false, forceWebView: false);
          } else {
            launch(blog.content.split("fbwatch")[1]);
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogDetailPageWrapper(blogOrId: blog)),
          );
        }
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => BlogDetailPageWrapper(blogOrId: blog)),
        // );
      },
      child: Container(
          margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: ExtendedImage.network(blog.thumbnail,
                          errorWidget: Image.asset(
                              "assets/images/product_placeholder.jpg"),
                          enableMemoryCache: true,
                          clearMemoryCacheWhenDispose: true,
                          clearMemoryCacheIfFailed: false,
                          fit: BoxFit.cover,
                          cache: true,
                          width: 350,
                          cacheHeight: 350)),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(blog.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).primaryTextTheme.subtitle1),
                        SizedBox(height: 10),
                        Flexible(
                          child: Container(
                            height: double.infinity,
                            child: Text(
                                paragraphIndex == null
                                    ? ""
                                    : elements[paragraphIndex].text,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle2),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
