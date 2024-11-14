import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<FetchTodoEvent>(onFetchTodos);
    on<AddTaskEvent>(onSubmitTodo);
    on<DeleteTodoEvent>(onDeleteTodo);
    on<UpdateTodoEvent>(updateTodo);
    on<FetchTodoEventById>(onFetchById);
    on<TodoEvent>((event, emit) {});
  }

  Future<void> onFetchTodos(
      FetchTodoEvent event, Emitter<TodoState> emit) async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    emit(TodoLoading());
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json['items'] as List;
        emit(TodoSuccess(result));
      } else {
        emit(const TodoError('Loading failed'));
      }
    } catch (e) {
      emit(TodoError('An Error Occured:$e'));
    }
  }

//Todo Submit
  Future<void> onSubmitTodo(AddTaskEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final body = {
      "title": event.title.trim(),
      "description": event.description.trim(),
      "is_completed": false,
    };
    const url = 'https://api.nstack.in/v1/todos';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(const TodoSuccess([], isTaskAdded: true));
        add(FetchTodoEvent());
      } else {
        emit(TodoError(
            'Error:${response.statusCode} - ${response.reasonPhrase}'));
      }
    } catch (error) {
      emit(TodoError('An error occured : $error'));
    }
  }

//Delete
  Future<void> onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    emit(TodoLoading());
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        add(FetchTodoEvent());
      } else {
        emit(TodoError('Failed to delete todo: ${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(TodoError('An error occured : $e'));
    }
  }

//Fetch By Id

  Future<void> onFetchById(
      FetchTodoEventById event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final todoItem = json['data'] as Map<String, dynamic>;
        emit(TodoSuccessById(todoItem));
      } else {
        emit(const TodoError('Failed to load'));
      }
    } catch (e) {
      emit(const TodoError('An error occured'));
    }
  }

  // Future<void> onUpdateTodo(
  //     UpdateTodoEvent event, Emitter<TodoState> emit) async {
  //   final url = 'https://api.nstack.in/v1/todos/${event.id}';
  //   emit(TodoLoading());
  //   try {
  //     final response = await http.put(Uri.parse(url),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({
  //           'title': event.title.trim(),
  //           'description': event.description.trim(),
  //         }));
  //     if (response.statusCode == 200) {
  //       add(FetchTodoEvent());
  //     } else {
  //       emit(TodoError('Failed to Update: ${response.reasonPhrase}'));
  //     }
  //   } catch (e) {
  //     emit(TodoError('An error occured:$e'));
  //   }
  // }
  Future<void> updateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final url = 'https://api.nstack.in/v1/todos/${event.id}';
    emit(TodoLoading());
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': event.title.trim(),
          'description': event.description.trim(),
        }),
      );
      if (response.statusCode == 200) {
        add(FetchTodoEvent());
      } else {
        emit(TodoError('Failed to update todo :${response.reasonPhrase}'));
      }
    } catch (e) {
      emit(TodoError('An error occured: $e'));
    }
  }
}
