// import 'package:flutter/material.dart';
// import 'package:lady_skin/src/features/blog/models/blog_comment.dart';

// import 'modal_comment_action.dart';

// class CommentItemTile extends StatelessWidget {
//   final BlogComment blogComment;
//   CommentItemTile({required this.blogComment});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () {
//         modalCommentAction(context, blogComment: blogComment);
//       },
//       child: Container(
//         width: double.infinity,
//         color: Colors.red.withOpacity(0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(
//                     color: Colors
//                         .grey[300]!, //                   <--- border color
//                     width: 1,
//                   ),
//                 ),
//                 width: 50,
//                 height: 50,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(100),
//                   child: blogComment.user.profileImage == ""
//                       ? Icon(Icons.people_outline)
//                       : Image(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(blogComment.user.profileImage),
//                         ),
//                 )),
//             SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           blogComment.user.name,
//                           style: Theme.of(context)
//                               .textTheme
//                               .subtitle1!
//                               .copyWith(fontWeight: FontWeight.w600),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                         Text(
//                           "${blogComment.text}",
//                           style: Theme.of(context).textTheme.bodyText2,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Text(
//                       "${blogComment.date}",
//                       style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                           color: Colors.grey[500],
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
