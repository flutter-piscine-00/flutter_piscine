// "userId": 10,
// "id": 99,
// "title": "temporibus sit alias delectus eligendi possimus magni",
// "body": "quo deleniti praesentium dicta non quod\naut est molestias\nmolestias et officia quis nihil\nitaque dolorem quia"

class Post {
  static const String getAllUrl = 'https://jsonplaceholder.typicode.com/posts';

  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Post.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        id = map['id'],
        title = map['title'],
        body = map['body'];
}
