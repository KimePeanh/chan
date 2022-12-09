import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/authentication/bloc/authentication_state.dart';
import 'package:lady_skin/src/features/authentication/bloc/index.dart';
import 'package:lady_skin/src/features/category/models/category_feature.dart';
import 'package:lady_skin/src/features/product/bloc/product_listing/product_listing_bloc.dart';

import 'package:lady_skin/src/features/product/repositories/product_listing_repository.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_list_by_subcategory.dart';

class ProductSubCategoryPage extends StatefulWidget {
  final CategoryFeature categoryFeature;
  ProductSubCategoryPage(
      {required this.initIndex, required this.categoryFeature});
  final int initIndex;

  @override
  _ProductSubCategoryPageState createState() => _ProductSubCategoryPageState();
}

class _ProductSubCategoryPageState extends State<ProductSubCategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initIndex,
      length: widget.categoryFeature.subCategories.length,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              widget.categoryFeature.name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textScaleFactor: 1.1,
            ),
            bottom: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.black,
                tabs: widget.categoryFeature.subCategories
                    .map(
                      (subCategory) => Tab(
                        text: subCategory.name,
                      ),
                    )
                    .toList()),
          ),
          body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (c, state) {
              if (state is Authenticating) {
                return Center(child: CircularProgressIndicator());
              } else {
                return TabBarView(
                  children: widget.categoryFeature.subCategories
                      .map((subCategory) => BlocProvider(
                            create: (context) => ProductListingBloc(
                                rowPerPage: 10,
                                productListingRepository:
                                    ProductListBySubCategoryRepo(
                                        isAuthenticated: (BlocProvider.of<
                                                    AuthenticationBloc>(context)
                                                .state is Authenticated
                                            ? true
                                            : false))),
                            child: ProductListBySubCategory(
                              subCategory: subCategory,
                            ),
                          ))
                      .toList(),
                );
              }
            },
          )),
    );
  }
}
