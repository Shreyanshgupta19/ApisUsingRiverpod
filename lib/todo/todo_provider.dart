import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import 'model.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredTodoListProvider = Provider<List<Todo>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final todos = ref.watch(todoListProvider);

  if (query.isEmpty) {
    return todos;
  } else {
    return todos.where((todo) => todo.title.toLowerCase().contains(query)).toList();
  }
});

class TodoList extends StateNotifier<List<Todo>> {
  TodoList() : super([]);

  final _uuid = Uuid();
  final ImagePicker _picker = ImagePicker();

  // Create
  void addTodo(String title) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        title: title,
      ),
    ];
  }

  // Update
  void toggleTodoStatus(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            title: todo.title,
            isCompleted: !todo.isCompleted,
            imagePath: todo.imagePath, // Keep the imagePath as it is
          )
        else
          todo,
    ];
  }

  // Add/Update image for a todo
  Future<void> addImageToTodo(String id) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera); // or ImageSource.gallery

    if (pickedFile != null) {
      state = [
        for (final todo in state)
          if (todo.id == id)
            Todo(
              id: todo.id,
              title: todo.title,
              isCompleted: todo.isCompleted,
              imagePath: pickedFile.path, // Store image path
            )
          else
            todo,
      ];
    }
  }

  // Delete
  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
