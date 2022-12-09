// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lady_skin/src/features/stores/bloc/store_bloc.dart';
// import 'package:lady_skin/src/features/stores/bloc/store_state.dart';
// import 'package:lady_skin/src/features/stores/screens/widgets/store_item_tile_horizontal.dart';

// class StoreListHorizontal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 15, right: 0),
//       child: AspectRatio(
//           aspectRatio: 10 / 4.8,
//           child: BlocBuilder<StoreBloc, StoreState>(
//             builder: (c, s) {
//               if (s is Initializing || s is FetchingStore) {
//                 return CircularProgressIndicator();
//               }
//               if (s is ErrorFetchingStore) {
//                 return Text(s.error);
//               }
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: BlocProvider.of<StoreBloc>(context).storeList.length,
//                 itemBuilder: (context, index) {
//                   return AspectRatio(
//                     aspectRatio: 4 / 3.2,
//                     child: storeItemTileHorizontal(
//                       store:
//                           BlocProvider.of<StoreBloc>(context).storeList[index],
//                     ),
//                   );
//                 },
//               );
//             },
//           )),
//     );
//   }
// }
