import 'package:flutter/material.dart';
import 'package:dsc_flutter_project/todo.dart';

class NewTodoDialog extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Todo'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: [
        TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
          child: Text('Add'),
          onPressed: () {
            final todo = Todo(title: controller.value.text);
            controller.clear();

            Navigator.of(context).pop(todo);
          },
        )
      ],
    );
  }
}
