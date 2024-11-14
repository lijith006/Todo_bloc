part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodoEvent extends TodoEvent {}

class AddTaskEvent extends TodoEvent {
  final String title;
  final String description;
  const AddTaskEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  const DeleteTodoEvent(this.id);
  @override
  List<Object> get props => [id];
}

class FetchTodoEventById extends TodoEvent {
  final String id;
  const FetchTodoEventById(this.id);
}

class UpdateTodoEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;
  const UpdateTodoEvent(
      {required this.id, required this.title, required this.description});
  @override
  List<Object> get props => [id, title, description];
}
