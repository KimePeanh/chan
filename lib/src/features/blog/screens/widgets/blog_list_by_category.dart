import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_category/blog_category_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_category/blog_category_event.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_category/blog_category_state.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_event.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_state.dart';
import 'package:lady_skin/src/features/blog/models/blog_category.dart';
import 'package:lady_skin/src/features/blog/repositories/blog_listing_repository.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'blog_list.dart';

class BlogListByCategoryWrapper extends StatefulWidget {
  final dynamic blogCategoryOrId;
  BlogListByCategoryWrapper({required this.blogCategoryOrId});

  @override
  _BlogListByCategoryWrapperState createState() =>
      _BlogListByCategoryWrapperState();
}

class _BlogListByCategoryWrapperState extends State<BlogListByCategoryWrapper> {
  final BlogCategoryBloc blogDetailBloc = BlogCategoryBloc();
  @override
  void dispose() {
    blogDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.blogCategoryOrId is BlogCategory) {
      return BlocProvider(
        create: (BuildContext context) => BlogListingBloc(
            blogListingRepository: BlogListByCategoryRepo())
          ..add(InitializeBlogList(arg: widget.blogCategoryOrId.id.toString())),
        child: BlogListByCategory(
          blogCategory: widget.blogCategoryOrId,
        ),
      );
    } else {
      blogDetailBloc.add(
          FetchBlogCategoryDetail(blogCategoryId: widget.blogCategoryOrId));
      return BlocConsumer(
          bloc: blogDetailBloc,
          listener: (c, state) {
            if (state is ErrorFetchingBlogCategoryDetail) {
              errorSnackBar(text: state.error.toString(), context: context);
            }
          },
          builder: (c, state) {
            if (state is ErrorFetchingBlogCategoryDetail) {
              return Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () {
                      blogDetailBloc.add(FetchBlogCategoryDetail(
                          blogCategoryId: widget.blogCategoryOrId));
                    },
                    child: Text("Retry"),
                  ),
                ),
              );
            } else if (state is FetchedBlogCategoryDetail) {
              return BlocProvider(
                create: (BuildContext context) => BlogListingBloc(
                    blogListingRepository: BlogListByCategoryRepo())
                  ..add(InitializeBlogList(
                      arg: state.blogCategory.id.toString())),
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      state.blogCategory.name,
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                    leading: IconButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_outlined)),
                    actions: [],
                  ),
                  body: BlogListByCategory(
                    blogCategory: state.blogCategory,
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          });
    }
  }
}

class BlogListByCategory extends StatefulWidget {
  final BlogCategory blogCategory;
  BlogListByCategory({required this.blogCategory});
  @override
  _BlogListByCategoryState createState() => _BlogListByCategoryState();
}

class _BlogListByCategoryState extends State<BlogListByCategory>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    BlocProvider.of<BlogListingBloc>(context)
        .add(InitializeBlogList(arg: widget.blogCategory.id));
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BlogListingBloc, BlogListingState>(
      builder: (context, state) {
        if (state is InitializingBlogList) {
          return Center(child: CircularProgressIndicator());
        }

        return BlocListener<BlogListingBloc, BlogListingState>(
          listener: (context, state) async {
            if (state is FetchedBlogList) {
              _refreshController.loadComplete();
              _refreshController.refreshCompleted();
            }
            if (state is EndOfBlogList) {
              _refreshController.loadNoData();
            }
          },
          child: SmartRefresher(
            scrollDirection: Axis.vertical,
            onRefresh: () {
              BlocProvider.of<BlogListingBloc>(context)
                  .add(InitializeBlogList(arg: widget.blogCategory.id));
            },
            onLoading: () {
              if (BlocProvider.of<BlogListingBloc>(context).state
                  is EndOfBlogList) {
              } else {
                BlocProvider.of<BlogListingBloc>(context)
                    .add(FetchBlogList(arg: widget.blogCategory.id));
              }
            },
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            child: BlogList(
                // isHorizontal: true,
                ),
          ),
        );
      },
    );
  }
}
