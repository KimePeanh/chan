import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lady_skin/src/features/category/bloc/index.dart';
import 'package:lady_skin/src/features/product/screens/widgets/product_list_by_store_category.dart';
import 'package:lady_skin/src/features/stores/models/store.dart';

class StoreProfilePage extends StatelessWidget {
  final Store store;
  StoreProfilePage({required this.store});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CategoryBloc(),
        child: Body(store: this.store));
  }
}

class Body extends StatefulWidget {
  final Store store;
  Body({required this.store});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context)
        .add(FetchCategoryByStore(storeId: widget.store.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is FetchingCategory) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (state is ErrorFetchingCategory) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else {
        return DefaultTabController(
          length: BlocProvider.of<CategoryBloc>(context).category.length,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_rounded),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    elevation: 0,
                    pinned: true,
                    expandedHeight:
                        (((100 / 2.27) * MediaQuery.of(context).size.width) /
                                100) -
                            MediaQuery.of(context).padding.top,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(""),
                      background: Image.network(
                        "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/156911654_3861039040598327_870102867332529030_o.jpg?_nc_cat=103&ccb=1-3&_nc_sid=973b4a&_nc_ohc=ulpDsMQ0yA4AX-3h9-g&_nc_ht=scontent.fpnh1-2.fna&oh=b31e7457752cbdab22ab2aeaf45cecc2&oe=607ADBB6",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: _storeDetail(store: widget.store)),

                  ///tabbar展示
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        tabs: BlocProvider.of<CategoryBloc>(context)
                            .category
                            .map(
                              (category) => Tab(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      category.name,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        unselectedLabelColor: Colors.grey[600],
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                          width: 3,
                          color: Theme.of(context).primaryColor,
                        )),
                      ),
                    ),
                    pinned: true,
                  )
                ];
              },
              body: TabBarView(
                children: BlocProvider.of<CategoryBloc>(context)
                    .category
                    .map((category) => ProductListByStoreCategory(
                          storeId: widget.store.id,
                          categoryId: category.id,
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      }
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

Widget _storeDetail({required Store store}) {
  return Container(
    margin: EdgeInsets.all(15),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 30,
                  child: FittedBox(
                    child: Image(
                      image: NetworkImage(
                          "https://scontent.fpnh1-2.fna.fbcdn.net/v/t1.0-9/57155585_2224717340897180_4067439225945980928_n.png?_nc_cat=1&ccb=1-3&_nc_sid=973b4a&_nc_ohc=tHkV7VA_2dMAX-_DkVL&_nc_ht=scontent.fpnh1-2.fna&oh=b41d438d208001c3ac3d5881664c25c1&oe=607A8FEA"),
                      // radius: 100,
                      // backgroundColor: Colors.red,
                      // child: Image(
                      //     image: NetworkImage(store["profile_image"])),
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  flex: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Xiaomi Cambodia",
                        textScaleFactor: 1.3,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.call_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "010601168",
                              textScaleFactor: 1.1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "app.anakutdigital@gmail.com",
                              textScaleFactor: 1.1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.language_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "www.anakutdigital.com",
                              textScaleFactor: 1.1,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "@Baktouk. St 168. Phnom Penh",
                              textScaleFactor: 1.1,
                            ),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "About",
            textScaleFactor: 1.3,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
              "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.",
              style: TextStyle(height: 2))
        ]),
  );
}
