// "postId": 1,
// "id": 3,
// "name": "odio adipisci rerum aut animi",
// "email": "Nikita@garfield.biz",
// "body": "quia molestiae reprehenderit quasi aspernatur\naut expedita occaecati aliquam eveniet laudantium\nomnis quibusdam delectus saepe quia accusamus maiores nam est\ncum et ducimus et vero voluptates excepturi deleniti ratione"

class Comment {
  static const String getAllUrl =
      'https://jsonplaceholder.typicode.com/comments';

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Comment.fromMap(Map<String, dynamic> map)
      : postId = map['postId'],
        id = map['id'],
        name = map['name'],
        email = map['email'],
        body = map['body'];
}
