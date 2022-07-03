import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const todoListKey = "todo_list";

class TodoRepository {
  late SharedPreferences sharedPreferences;

  void saveTodoList(List<TodoItem> todoItems) {
    final jsonString = json.encode(todoItems);
    sharedPreferences.setString(todoListKey, jsonString);
  }

  Future<List<TodoItem>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;

    final List<TodoItem> decodedTodoItems = jsonDecoded
        .map(
          (e) => TodoItem.fromJson(e),
        )
        .toList();

    return decodedTodoItems;
  }
}
