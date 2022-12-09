import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/appLocalizations.dart';
import 'package:lady_skin/src/features/app/screens/app_page.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_category/blog_category_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_category/blog_category_event.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_category/blog_category_state.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_bloc.dart';
import 'package:lady_skin/src/features/blog/bloc/blog_listing/blog_listing_event.dart';
import 'package:lady_skin/src/features/blog/repositories/blog_listing_repository.dart';
import 'package:lady_skin/src/shared/bloc/invoking/invoking_state.dart';
import 'widgets/blog_list_by_all.dart';
import 'widgets/blog_list_by_category.dart';

class BlogPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: AppPageState.bottomNavigationPagesInvokingBloc[2],
        builder: (context, state) {
          if (state is Invoked) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (BuildContext context) =>
                      BlogCategoryBloc()..add(FetchBlogCategoryStarted()),
                ),
                // BlocProvider(
                //   create: (BuildContext context) =>
                //       BlogListingBloc(blogListingRepository: BlogListRepo())
                //         ..add(InitializeBlogList()),
                // )
              ],
              child: BlogPage(),
            );
          }
          return Container();
        });
  }
}

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCategoryBloc, BlogCategoryState>(
        builder: (context, state) {
      if (state is ErrorFetchingBlogCategory) {
        return Scaffold(
          body: Center(
            child: TextButton(
                onPressed: () {
                  BlocProvider.of<BlogCategoryBloc>(context)
                      .add(FetchBlogCategoryStarted());
                },
                child: Text("Retry")),
          ),
        );
      } else if (state is FetchedBlogCategory) {
        return DefaultTabController(
          initialIndex: 0,
          length: 1 +
              BlocProvider.of<BlogCategoryBloc>(context)
                  .blogCategoryList
                  .length,
          child: Scaffold(
            appBar: AppBar(
              // centerTitle: true,
              title: Text(
                AppLocalizations.of(context)!.translate("blog"),
                style: Theme.of(context).primaryTextTheme.headline6,
              ),
              actions: [
                // IconButton(
                //     icon: Icon(
                //       Icons.search,
                //       color: Colors.black,
                //       size: 30,
                //     ),
                //     onPressed: () {})
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    //  (_blogCategoryBloc.subCategoryList.length == 0)
                    //     ? false
                    //     : true,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Container(
                        padding: EdgeInsets.all(1),
                        child: Tab(
                            text:
                                AppLocalizations.of(context)!.translate("all")),
                      ),
                      ...BlocProvider.of<BlogCategoryBloc>(context)
                          .blogCategoryList
                          .map((subCategory) => Tab(text: subCategory.name))
                          .toList()
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                BlocProvider(
                    create: (BuildContext context) =>
                        BlogListingBloc(blogListingRepository: BlogListRepo())
                          ..add(InitializeBlogList()),
                    child: BlogListByAll()),
                ...BlocProvider.of<BlogCategoryBloc>(context)
                    .blogCategoryList
                    .map(
                      (blogCategory) => BlocProvider(
                          create: (context) => BlogListingBloc(
                              blogListingRepository: BlogListByCategoryRepo())
                            ..add(InitializeBlogList(
                                arg: blogCategory.id.toString())),
                          child: BlogListByCategory(
                            blogCategory: blogCategory,
                          )
                          //_body(subCategory.id.toString()),
                          ),
                    )
                    .toList()
              ],
            ),
          ),
        );
      }
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
