class Todo {
  int? id;
  String title;
  String? description;
  bool completed;

  Todo({
    this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "completed": completed,
      };

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}
