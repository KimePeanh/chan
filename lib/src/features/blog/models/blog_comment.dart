import 'package:lady_skin/src/features/account/models/user.dart';

class BlogComment {
  final String id;
  final String text;
  final String date;
  final User user;
  factory BlogComment.fromJson(Map<String, dynamic> json) {
    return BlogComment(
        id: json["id"].toString(),
        text: json["message"],
        date: json["date"],
        user: User.fromJson(json["user"]));
  }
  BlogComment(
      {required this.id,
      required this.text,
      required this.date,
      required this.user});
}
