import 'package:flutter/material.dart';
import 'package:flutter_demo_app/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Status: "),
                const SizedBox(width: 8),
                switch (todo.userId) {
                  1 => CircleAvatar(
                    backgroundColor: Colors.red,
                    child: const Text('All'),
                  ),
                  2 => Container(
                    color: Colors.yellow,
                    padding: EdgeInsets.all(4),
                    child: const Text('Pending'),
                  ),
                  3 => Container(
                    color: Colors.green,
                    padding: EdgeInsets.all(4),
                    child: const Text('Completed'),
                  ),
                  4 => Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(4),
                    child: const Text('Draft'),
                  ),
                  _ => const SizedBox(),
                },
              ],
            ),
            const SizedBox(height: 8),
            Text(
              todo.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              todo.body ?? '',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
