import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_tile.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_tile_skeleton.dart';
import 'package:lady_skin/src/features/search/bloc/index.dart';

import '../search_page.dart';

class SearchResult extends StatefulWidget {
  SearchResult({required this.query, required this.auth});
  final String query;
  final String auth;
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    searchBloc.add(SearchStarted(query: widget.query, isauth: widget.auth == "Authenticated()"? true : false, ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: searchBloc,
      listener: (context, state) {
        if (state is Searched) {
          _refreshController.loadComplete();
        } else if (state is ErrorSearching) {
          _refreshController.loadFailed();
        }
      },
      child: SmartRefresher(
        onLoading: () {
          searchBloc.add(SearchStarted(query: widget.query, isauth: widget.auth == "Authenticated()"? true : false,));
        },
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        enablePullDown: false,
        enablePullUp: true,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: BlocBuilder(
              bloc: searchBloc,
              builder: (BuildContext context, state) {
                if (state is Searching && state.isInitiallySearch) {
                  return Container(
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 4 / 5.7,
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2),
                      itemCount: searchBloc.results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {},
                            child: ProductTile(
                                product: searchBloc.results[index]));
                      },
                    ),
                    (state is Searching && state.isInitiallySearch == false)
                        ? GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 4 / 5.7,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 7),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return productTileSkeleton();
                            },
                          )
                        : Container()
                  ],
                );
              }),
        ),
      ),
    );
  }
}
