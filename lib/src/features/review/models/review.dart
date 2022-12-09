class Review {
  final String id;
  final String reviewer;
  final String? comment;
  final String star;
  final String date;
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json["id"].toString(),
        reviewer: json["name"],
        comment: json["comment"],
        star: json["star"] == null ? 0 : json["star"],
        date: json["date"]);
  }
  Review(
      {required this.id,
      required this.reviewer,
      required this.comment,
      required this.star,
      required this.date});
}
