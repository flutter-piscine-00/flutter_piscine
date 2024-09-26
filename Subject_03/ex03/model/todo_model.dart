class TodoModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  TodoModel.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        id = map['id'],
        title = map['title'],
        completed = map['completed'];
}
