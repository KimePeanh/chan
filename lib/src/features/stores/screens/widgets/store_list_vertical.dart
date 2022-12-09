// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lady_skin/src/features/stores/bloc/store_bloc.dart';
// import 'package:lady_skin/src/features/stores/bloc/store_state.dart';
// import 'package:lady_skin/src/features/stores/screens/widgets/store_item_tile_vertical.dart';

// class StoreListVertical extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<StoreBloc, StoreState>(
//       builder: (c, s) {
//         if (s is Initializing || s is FetchingStore) {
//           return CircularProgressIndicator();
//         }
//         if (s is ErrorFetchingStore) {
//           return Text(s.error);
//         }
//         // return Container(
//         //   child: ListView(
//         //     shrinkWrap: true,
//         //     physics: NeverScrollableScrollPhysics(),
//         //     children: [Text("hhfh")],
//         //   ),
//         // );
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.vertical,
//           itemCount: BlocProvider.of<StoreBloc>(context).storeList.length,
//           itemBuilder: (context, index) {
//             return Container(
//               margin: EdgeInsets.only(bottom: 10),
//               child: storeItemTileVertical(
//                 store: BlocProvider.of<StoreBloc>(context).storeList[index],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
