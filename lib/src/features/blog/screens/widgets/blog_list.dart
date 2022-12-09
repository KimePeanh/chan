import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_state.dart';
import 'blog_tile.dart';
import 'blog_tile_skeleton.dart';

class BlogList extends StatefulWidget {
  final bool isForVerticalScrolling;
  BlogList({this.isForVerticalScrolling = true});

  @override
  _BlogListState createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  Widget build(BuildContext context) {
    if (widget.isForVerticalScrolling == false) {
      return BlocBuilder<BlogListingBloc, BlogListingState>(
          builder: (BuildContext context, BlogListingState state) {
        print(state);
        if (BlocProvider.of<BlogListingBloc>(context).blogList.length == 0) {
          return Container(
            width: 0,
            height: 0,
          );
        }
        return Container();
        //  return Text("hh");
        // return Container(
        //   margin: EdgeInsets.only(left: 10, right: 0),
        //   child: ListView.builder(
        //     cacheExtent: 10,
        //     shrinkWrap: true,
        //     // physics: NeverScrollableScrollPhysics(),
        //     scrollDirection: Axis.horizontal,
        //     itemCount:
        //         BlocProvider.of<BlogListingBloc>(context).blogList.length,
        //     itemBuilder: (context, index) {
        //       return AspectRatio(
        //         aspectRatio: 4 / 5.8,
        //         child: Container(
        //             margin: EdgeInsets.only(right: 5), child: Text("Blog")
        //             // ProductTile(
        //             //   isVerticalParent: false,
        //             //   //showIcon: true,
        //             //   product: BlocProvider.of<BlogListingBloc>(context)
        //             //       .productList[index],
        //             // ),
        //             ),
        //       );
        //     },
        //   ),
        // );
      });
    }
    print(BlocProvider.of<BlogListingBloc>(context).blogList.length);

    return Container(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<BlogListingBloc, BlogListingState>(
        builder: (context, state) {
          print(BlocProvider.of<BlogListingBloc>(context).blogList.length);
          if (state is InitializingBlogList) {
            return GridView.builder(
              // cacheExtent: 10,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 10 / 3.5,
                  crossAxisCount: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10),
              itemCount: 6,
              itemBuilder: (context, index) {
                return blogTileSkeleton();
              },
            );
          } else if (state is ErrorFetchingBlogList) {
            return Container();
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  BlocProvider.of<BlogListingBloc>(context).blogList.length,
              itemBuilder: (c, index) {
                print(index);
                return AspectRatio(
                  aspectRatio: 10 / 3.5,
                  child: BlogTile(
                      blog: BlocProvider.of<BlogListingBloc>(context)
                          .blogList[index]),
                );
              });
          return Column(
            children: [
              GridView.builder(
                cacheExtent: 0,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // padding: EdgeInsets.only(left: 10, top: 10, right: 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 5.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10),
                itemCount:
                    BlocProvider.of<BlogListingBloc>(context).blogList.length,
                itemBuilder: (context, index) {
                  return Text("Blog2");
                  // return ProductTile(
                  //   // showIcon: true,
                  //   product: BlocProvider.of<BlogListingBloc>(context)
                  //       .productList[index],
                  // );
                },
              ),
              // (state is FetchingBlogList)
              // ? GridView.builder(
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         childAspectRatio: 4 / 5.7,
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 8,
              //         mainAxisSpacing: 10),
              //     itemCount: 6,
              //     itemBuilder: (context, index) {
              //       return productTileSkeleton();
              //     },
              //   )
              // : Container()
            ],
          );
        },
      ),
    );
  }
}
