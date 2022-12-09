// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lady_skin/src/features/account/bloc/account_bloc.dart';
// import 'package:lady_skin/src/features/blog/models/blog_comment.dart';

// modalCommentAction(BuildContext context, {required BlogComment blogComment}) {
//   return showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(24),
//         topRight: Radius.circular(24),
//       ),
//     ),
//     isDismissible: true,
//     builder: (context) => WillPopScope(
//       onWillPop: () async => true,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // titleWidget ??
//             //     Text(
//             //       title,
//             //       textAlign: TextAlign.left,
//             //       style: Theme.of(context).textTheme.headline2,
//             //     ),
//             // SizedBox(height: 0),
//             Row(
//               children: [
//                 Icon(Icons.copy),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Text(
//                   "Copy",
//                   style: Theme.of(context)
//                       .textTheme
//                       .subtitle1!
//                       .copyWith(fontWeight: FontWeight.w600),
//                 )
//               ],
//             ),
//             BlocProvider.of<AccountBloc>(context).state.user != null &&
//                     (BlocProvider.of<AccountBloc>(context).state.user!.id ==
//                         blogComment.user.id)
//                 ? Column(
//                     children: [
//                       SizedBox(
//                         height: 25,
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.edit_outlined),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text(
//                             "Edit",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle1!
//                                 .copyWith(fontWeight: FontWeight.w600),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 25,
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.delete_outlined),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text(
//                             "Delete",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle1!
//                                 .copyWith(fontWeight: FontWeight.w600),
//                           )
//                         ],
//                       ),
//                     ],
//                   )
//                 : Center()

//             // contentWidget ??
//             //     Text(
//             //       content,
//             //       textAlign: TextAlign.left,
//             //       style: Theme.of(context)
//             //           .textTheme
//             //           .bodyText2
//             //           .copyWith(height: 1.5),
//             //     ),
//             // SizedBox(height: 20),
//             // if (actions != null)
//             //   ...actions
//             // else
//             //   OutlineButton(
//             //     child: Text('GOT IT!'),
//             //     borderSide: BorderSide(color: theme.primaryColor),
//             //     onPressed: () {
//             //       Navigator.of(context).pop();
//             //     },
//             //   ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
