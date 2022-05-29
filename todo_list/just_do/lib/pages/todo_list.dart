import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_list_item.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<TodoItem> todos = [];
  TodoItem? deletedTodo;
  int? deletedTodoPosition;

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Lista de tarefas",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Ex: Estudar matematica.",
                            labelText: "Adicione uma tarefa"),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController.text;
                        TodoItem newTodoItem =
                            TodoItem(title: text, datetime: DateTime.now());
                        setState(() {
                          todos.add(newTodoItem);
                        });
                        todoController.clear();
                      },
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.all(16),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (TodoItem todo in todos)
                        TodoListItem(
                          todoItem: todo,
                          onDelete: onDelete,
                          onEdit: onEdit,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Você possui ${todos.length} tarefas pendentes!"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: showDeleteAllTodosDialog,
                      child: const Text("Limpar"),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(TodoItem todo) {
    deletedTodo = todo;
    deletedTodoPosition = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tarefa '${todo.title}' deletada com sucess"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPosition!, deletedTodo!);
            });
          },
        ),
      ),
    );
  }

  void onEdit(TodoItem todo) {
    setState(() {
      todo.title = "Atualizado";
      todo.datetime = DateTime.now();
    });
  }

  void showDeleteAllTodosDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar tudo!"),
        content:
            const Text("Você tem certeza que deseja apagar todas as tarefas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                todos.clear();
              });
              Navigator.of(context).pop();
            },
            child: const Text(
              "Apagar tudo",
            ),
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
