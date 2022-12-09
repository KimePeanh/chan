import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lady_skin/src/features/product/bloc/index.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_list.dart';

class ProductListByCategory extends StatefulWidget {
  final String categoryId;
  ProductListByCategory({required this.categoryId});

  @override
  _ProductListByCategoryState createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory>
    with AutomaticKeepAliveClientMixin<ProductListByCategory> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => ProductBloc()
        ..add(FetchByCategoryStarted(categoryId: widget.categoryId)),
      child: Body(
        categoryId: widget.categoryId,
      ),
    );
  }
}

class Body extends StatelessWidget {
  final String categoryId;
  Body({required this.categoryId});
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is FetchedProduct) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
      },
      child: SmartRefresher(
        onRefresh: () {
          BlocProvider.of<ProductBloc>(context).add(
              FetchByCategoryStarted(isRefresh: true, categoryId: categoryId));
        },
        onLoading: () {
          BlocProvider.of<ProductBloc>(context).add(
              FetchByCategoryStarted(isRefresh: false, categoryId: categoryId));
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
    );
  }
}
