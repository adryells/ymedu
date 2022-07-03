import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todoItem,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  final TodoItem todoItem;
  final Function(TodoItem) onDelete;
  final Function(TodoItem) onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey[300],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat("dd/MMM/yyyy - HH:mm").format(todoItem.datetime),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                todoItem.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        key: const ValueKey(0),
        endActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(todoItem);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
            SlidableAction(
              onPressed: (context) {
                onEdit(todoItem);
              },
              backgroundColor: const Color.fromARGB(255, 57, 132, 17),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
          ],
        ),
      ),
    );
  }
}
