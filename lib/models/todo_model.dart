import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String title;
  final String? body;
  final int userId;
  final int id;

  const Todo({
    required this.title,
    this.body,
    required this.userId,
    required this.id,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'] as String,
      body: json['body'] as String?,
      userId: json['userId'] as int,
      id: json['id'] as int,
    );
  }

  @override
  List<Object?> get props => [title, body, userId, id];
}
