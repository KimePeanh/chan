// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lady_skin/src/features/app/screens/app_page.dart';
// import 'package:lady_skin/src/features/product/bloc/index.dart';
// import 'package:lady_skin/src/features/stores/bloc/store_bloc.dart';
// import 'package:lady_skin/src/features/stores/bloc/store_event.dart' as s;
// import 'package:lady_skin/src/features/stores/screens/widgets/appbar.dart';
// import 'package:lady_skin/src/shared/bloc/indexing/index.dart';

// import 'package:lady_skin/src/shared/bloc/invoking/invoking_state.dart';

// import 'widgets/store_list_all.dart';
// import 'widgets/store_list_recommend.dart';
// import 'widgets/vendor_slider.dart';

// class StorePageWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder(
//       bloc: AppPageState.bottomNavigationPagesInvokingBloc[2],
//       builder: (BuildContext context, InvokingState state) {
//         if (state is Sleeping) {
//           return Container(
//             child: Text("Sleeping"),
//           );
//         } else {
//           return BlocProvider(
//             create: (BuildContext context) =>
//                 ProductBloc()..add(FetchStarted()),
//             child: BlocProvider(
//                 create: (BuildContext context) =>
//                     StoreBloc()..add(s.FetchStarted()),
//                 child: StorePage()),
//           );
//         }
//       },
//     );
//   }
// }

// class StorePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).primaryColor,
//         appBar: PreferredSize(
//           preferredSize: const Size(double.infinity, kToolbarHeight),
//           child: appBar(context: context),
//         ),
//         body: LayoutBuilder(
//           builder: (context, constraint) {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   BlocProvider(
//                       create: (BuildContext context) => IndexingBloc(),
//                       child: VendorSlider()),
//                   Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(18.0),
//                             topRight: Radius.circular(18.0)),
//                         color: Colors.white),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 5,
//                         ),
//                         StoreListRecommend(),
//                         StoreListAll(),
//                         // StoreListVertical(),
//                       ],
//                     ),
//                   ),
//                   // Expanded(
//                   //   child: ListView(
//                   //     shrinkWrap: true,
//                   //     physics: NeverScrollableScrollPhysics(),
//                   //     children: [Text("hhfh")],
//                   //   ),
//                   // )
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }
