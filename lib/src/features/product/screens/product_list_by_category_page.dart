import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/category/bloc/category_detail/category_detail_bloc.dart';
import 'package:lady_skin/src/features/category/bloc/category_detail/category_detail_event.dart';
import 'package:lady_skin/src/features/category/bloc/category_detail/category_detail_state.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_event.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_state.dart';
import 'package:lady_skin/src/shared/widgets/error_snackbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lady_skin/src/features/category/models/category.dart';
import 'package:lady_skin/src/features/product/repositories/product_listing_repository.dart';
import 'package:lady_skin/src/features/sub_category/bloc/index.dart';

import 'widgets/product_list.dart';

class ProductListByCategoryPageWrapper extends StatefulWidget {
  final dynamic categoryOrId;
  ProductListByCategoryPageWrapper({required this.categoryOrId});

  @override
  _ProductListByCategoryPageWrapperState createState() =>
      _ProductListByCategoryPageWrapperState();
}

class _ProductListByCategoryPageWrapperState
    extends State<ProductListByCategoryPageWrapper> {
  final CategoryDetailBloc blogDetailBloc = CategoryDetailBloc();
  @override
  void dispose() {
    blogDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categoryOrId is Category) {
      return ProductListByCategoryPage(
        category: widget.categoryOrId,
      );
    } else {
      blogDetailBloc.add(FetchCategoryDetail(categoryId: widget.categoryOrId));
      return BlocConsumer(
          bloc: blogDetailBloc,
          listener: (c, state) {
            if (state is ErrorFetchingCategoryDetail) {
              errorSnackBar(text: state.error.toString(), context: context);
            }
          },
          builder: (c, state) {
            if (state is ErrorFetchingCategoryDetail) {
              // errorSnackBar(text: state.error.toString(), context: context);
              return Scaffold(
                body: Center(
                  child: TextButton(
                    onPressed: () {
                      blogDetailBloc.add(
                          FetchCategoryDetail(categoryId: widget.categoryOrId));
                    },
                    child: Text("Retry"),
                  ),
                ),
              );
            } else if (state is FetchedCategoryDetail) {
              return ProductListByCategoryPage(
                category: state.category,
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

class ProductListByCategoryPage extends StatefulWidget {
  final Category category;
  ProductListByCategoryPage({required this.category});

  @override
  _ProductListByCategoryPageState createState() =>
      _ProductListByCategoryPageState();
}

class _ProductListByCategoryPageState extends State<ProductListByCategoryPage> {
  SubCategoryBloc _subCategoryBloc = SubCategoryBloc();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _subCategoryBloc
        .add(FetchSubCategoryStarted(categoryId: widget.category.id));
    super.initState();
  }

  void dispose() {
    _subCategoryBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<SubCategory> subCategoryList;
    // this.
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (c, state) {
        if (state is Authenticating) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return BlocBuilder(
              bloc: _subCategoryBloc,
              builder: (context, state) {
                // Helper.handleState(state: state, context: context);
                if (state is ErrorFetchingSubCategory) {
                  return Scaffold(
                    body: Center(
                      child: TextButton(
                          onPressed: () {
                            _subCategoryBloc.add(FetchSubCategoryStarted(
                                categoryId: widget.category.id));
                          },
                          child: Text("Retry")),
                    ),
                  );
                } else if (state is FetchedSubCategory) {
                  return DefaultTabController(
                    initialIndex: 0,
                    length: 1 + _subCategoryBloc.subCategoryList.length,
                    child: Scaffold(
                      appBar: AppBar(
                        brightness: Theme.of(context).brightness,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        centerTitle: true,
                        title: Text(
                          widget.category.name,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textScaleFactor: 1.1,
                        ),
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(kToolbarHeight),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              //  (_subCategoryBloc.subCategoryList.length == 0)
                              //     ? false
                              //     : true,
                              indicatorColor: Theme.of(context).primaryColor,
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Container(
                                  padding: EdgeInsets.all(1),
                                  child: Tab(
                                    text: "All",
                                  ),
                                ),
                                ..._subCategoryBloc.subCategoryList
                                    .map((subCategory) =>
                                        Tab(text: subCategory.name))
                                    .toList()
                              ],
                            ),
                          ),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          TabBarContent(
                              arg: widget.category.id,
                              productListingRepository:
                                  ProductListByCategoryRepo(
                                      isAuthenticated:
                                          (BlocProvider.of<AuthenticationBloc>(
                                                      context)
                                                  .state is Authenticated
                                              ? true
                                              : false))),
                          // BlocProvider(
                          //     create: (context) => ProductListingBloc(
                          //         productListingRepository:
                          //             ProductListByCategoryRepo())
                          //       ..add(InitializeProductList(
                          //           arg: widget.category.id.toString())),
                          //     child: _body(widget.category.id.toString())),
                          ..._subCategoryBloc.subCategoryList
                              .map(
                                (subCategory) => BlocProvider(
                                  create: (context) => ProductListingBloc(
                                      productListingRepository:
                                          ProductListBySubCategoryRepo(
                                              isAuthenticated: (BlocProvider.of<
                                                              AuthenticationBloc>(
                                                          context)
                                                      .state is Authenticated
                                                  ? true
                                                  : false)))
                                    ..add(InitializeProductList(
                                        arg: subCategory.id.toString())),
                                  child: _body(subCategory.id.toString()),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                  );
                }
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              });
        }
      },
    );
  }

  _body(String arg) {
    return Builder(
        builder: (context) =>
            BlocListener<ProductListingBloc, ProductListingState>(
              listener: (context, state) {
                if (state is InitializedProductList ||
                    state is FetchedProductList) {
                  _refreshController.loadComplete();
                  _refreshController.refreshCompleted();
                }
                if (state is EndOfProductList) {
                  _refreshController.loadNoData();
                }
              },
              child: SmartRefresher(
                onRefresh: () {
                  BlocProvider.of<ProductListingBloc>(context)
                      .add(InitializeProductList(arg: arg));
                },
                onLoading: () {
                  if (BlocProvider.of<ProductListingBloc>(context).state
                      is EndOfProductList) {
                  } else {
                    BlocProvider.of<ProductListingBloc>(context)
                        .add(FetchProductList(arg: arg));
                  }
                },
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                child: SingleChildScrollView(
                  child: Column(
                    children: [ProductList()],
                  ),
                ),
              ),
            ));
  }
}

class TabBarContent extends StatefulWidget {
  final String arg;
  final ProductListingRepository productListingRepository;
  TabBarContent({required this.arg, required this.productListingRepository});
  @override
  _TabBarContentState createState() => _TabBarContentState();
}

class _TabBarContentState extends State<TabBarContent>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _customProductListingBlocProvider(
        productListingRepo: widget.productListingRepository,
        arg: widget.arg,
        child: _body());
  }

  _body() {
    return Builder(
        builder: (context) =>
            BlocListener<ProductListingBloc, ProductListingState>(
              listener: (context, state) {
                if (state is InitializedProductList ||
                    state is FetchedProductList) {
                  _refreshController.loadComplete();
                  _refreshController.refreshCompleted();
                }
                if (state is EndOfProductList) {
                  _refreshController.loadNoData();
                }
              },
              child: SmartRefresher(
                onRefresh: () {
                  BlocProvider.of<ProductListingBloc>(context)
                      .add(InitializeProductList(arg: widget.arg));
                },
                onLoading: () {
                  if (BlocProvider.of<ProductListingBloc>(context).state
                      is EndOfProductList) {
                  } else {
                    BlocProvider.of<ProductListingBloc>(context)
                        .add(FetchProductList(arg: widget.arg));
                  }
                },
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                child: SingleChildScrollView(
                  child: Column(
                    children: [ProductList()],
                  ),
                ),
              ),
            ));
  }
}

_customProductListingBlocProvider(
    {required ProductListingRepository productListingRepo,
    required String arg,
    required Widget child}) {
  return BlocProvider(
      create: (context) =>
          ProductListingBloc(productListingRepository: productListingRepo)
            ..add(InitializeProductList(arg: arg)),
      child: child);
}
