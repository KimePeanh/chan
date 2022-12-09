class MyNotification {
  final String id;
  final String title;
  final String body;
  final String date;
  final String? target;
  final String? targetValue;
  factory MyNotification.fromJson(Map<String, dynamic> json) {
    return MyNotification(
        id: json["id"].toString(),
        title: json["title"],
        body: json["comment"],
        date: json["date"],
        target: json["target"],
        targetValue: json["target_value"] == null
            ? null
            : json["target_value"].toString());
  }
  MyNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.target,
      required this.targetValue});
}
