class Todo {
  int? id;
  String title;
  bool completed;
  int? userId;

  Todo({
    this.id,
    required this.title,
    this.completed = false,
    this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "completed": completed,
        "userId": userId,
      };

  Todo copyWith({
    int? id,
    String? title,
    bool? completed,
    int? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }
}
