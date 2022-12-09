import 'dart:developer';

class Blog {
  final String id;
  final String date;
  final String thumbnail;
  final String content;
  final String title;
  factory Blog.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return Blog(
        id: json["id"].toString(),
        title: json["title"],
        thumbnail: json["thumbnail_url"],
        content: json["content"].toString().replaceAll(r"\", ""),
        date: json["created_at"]);
  }
  Blog(
      {required this.id,
      required this.date,
      required this.thumbnail,
      required this.content,
      required this.title});
}
