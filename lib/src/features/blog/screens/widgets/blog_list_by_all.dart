import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_event.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'blog_list.dart';

class BlogListByAll extends StatefulWidget {
  @override
  _BlogListByAllState createState() => _BlogListByAllState();
}

class _BlogListByAllState extends State<BlogListByAll>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<BlogListingBloc, BlogListingState>(
      listener: (context, state) {
        if (state is InitializedBlogList || state is FetchedBlogList) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndOfBlogList) {
          _refreshController.loadNoData();
        }
      },
      child: SmartRefresher(
        cacheExtent: 1,
        // cacheExtent: 500,
        physics: AlwaysScrollableScrollPhysics(),
        onRefresh: () {
          BlocProvider.of<BlogListingBloc>(context).add(InitializeBlogList());
        },
        onLoading: () {
          if (BlocProvider.of<BlogListingBloc>(context).state
              is EndOfBlogList) {
          } else {
            BlocProvider.of<BlogListingBloc>(context)
                .add(FetchBlogList(arg: null));
          }
        },
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            // addAutomaticKeepAlives: true,
            children: [
              // BlocBuilder<BlogCategoryBloc, BlogCategoryState>(
              //   builder: (context, state) {
              //     if (state is FetchingBlogCategory) {
              //       return Container();
              //       // return Center(child: CircularProgressIndicator());
              //     } else if (state is ErrorFetchingBlogCategory) {
              //       return Container();
              //     } else {
              //       return ListView.builder(
              //         physics: NeverScrollableScrollPhysics(),
              //         itemCount: BlocProvider.of<BlogCategoryBloc>(context)
              //             .blogCategoryList
              //             .length,
              //         shrinkWrap: true,
              //         itemBuilder: (context, index) => BlocProvider(
              //           create: (BuildContext context) => BlogListingBloc(
              //               blogListingRepository: BlogListByCategoryRepo(),
              //               rowPerPage: 3)
              //             ..add(InitializeBlogList(
              //                 arg: BlocProvider.of<BlogCategoryBloc>(context)
              //                     .blogCategoryList[index]
              //                     .id)),
              //           child:
              //               // Text("Hi")
              //               BlogListByBlogCategory(
              //             category: BlocProvider.of<BlogCategoryBloc>(context)
              //                 .blogCategoryList[index],
              //           ),
              //         ),
              //       );
              //     }
              //   },
              // ),
              SizedBox(height: 15),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.only(left: 10, right: 0),
              //   //alignment: Alignment.centerLeft,
              //   child: Text("Feature",
              //       textScaleFactor: 1.1,
              //       style: TextStyle(
              //           letterSpacing: 1,
              //           color: Theme.of(context).textTheme.headline1!.color,
              //           fontWeight: FontWeight.w500)),
              // ),
              BlogList()
            ],
          ),
        ),
      ),
    );
  }
}
