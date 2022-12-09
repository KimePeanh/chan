// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lady_skin/src/features/category/models/category.dart';
// import 'package:lady_skin/src/features/product/screens/widgets/product_list_by_category.dart';
// import 'package:lady_skin/src/features/product/screens/widgets/product_list_by_sub_category.dart';
// import 'package:lady_skin/src/features/sub_category/bloc/index.dart';

// class SubCategoryProductWrapperPage extends StatelessWidget {
//   final Category category;
//   SubCategoryProductWrapperPage({required this.category});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => SubCategoryBloc()
//           ..add(FetchSubCategoryStarted(categoryId: this.category.id)),
//         child: Body(category: this.category));
//   }
// }

// class Body extends StatelessWidget {
//   final Category category;
//   Body({required this.category});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SubCategoryBloc, SubCategoryState>(builder: (c, s) {
//       if (s is FetchingSubCategory) {
//         return Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       }
//       if (s is ErrorFetching) {
//         return Scaffold(
//           body: Center(
//             child: Text(s.error),
//           ),
//         );
//       } else {
//         List<String> subCategoryTitleList = [];
//         List<Widget> productListContents = [];
//         subCategoryTitleList.add("All");
//         productListContents.add(ProductListByCategory(
//           categoryId: category.id,
//         ));
//         BlocProvider.of<SubCategoryBloc>(context).subCategory.forEach((sub) {
//           subCategoryTitleList.add(sub.name);
//           productListContents.add(ProductListBySubCategory(
//             subCategoryId: sub.id,
//           ));
//         });
//         return DefaultTabController(
//           initialIndex: 0,
//           length: productListContents.length,
//           child: Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 color: Colors.black,
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               centerTitle: true,
//               title: Text(this.category.name),
//               bottom: PreferredSize(
//                 preferredSize: const Size.fromHeight(kToolbarHeight),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: TabBar(
//                       labelColor: Colors.black,
//                       labelStyle: TextStyle(color: Colors.black),
//                       isScrollable: true,
//                       labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
//                       unselectedLabelColor: Colors.grey[600],
//                       indicatorSize: TabBarIndicatorSize.label,
//                       indicator: UnderlineTabIndicator(
//                           borderSide: BorderSide(
//                         width: 3,
//                         color: Color(0xFF646464),
//                       )),
//                       tabs: subCategoryTitleList
//                           .map(
//                             (title) => Tab(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     title,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                           .to[]),
//                 ),
//               ),
//             ),
//             body: TabBarView(
//               children: productListContents,
//             ),
//           ),
//         );
//       }
//     });
//   }
// }
