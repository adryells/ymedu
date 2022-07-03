class TodoItem {
  TodoItem({required this.title, required this.datetime});

  TodoItem.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        datetime = DateTime.parse(json["datetime"]);

  String title;
  DateTime datetime;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "datetime": datetime.toIso8601String(),
    };
  }
}
