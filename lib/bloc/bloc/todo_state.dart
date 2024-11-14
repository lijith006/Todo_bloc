part of 'todo_bloc.dart';

@immutable
sealed class TodoState extends Equatable {
  const TodoState();
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

//TodoSuccess
class TodoSuccess extends TodoState {
  final List items;
  //Add flag if task added
  final bool isTaskAdded;
  //default :false
  const TodoSuccess(this.items, {this.isTaskAdded = false});
  @override
  List<Object> get props => [items, isTaskAdded];
}

//TodoSuccessById
class TodoSuccessById extends TodoState {
  final Map<String, dynamic> todo;
  const TodoSuccessById(this.todo);
}

//TodoError msg

class TodoError extends TodoState {
  final String msg;
  const TodoError(this.msg);
}

class TodoUpdateState extends TodoState {
  final List<Map<String, dynamic>> updateDetails;
  const TodoUpdateState(this.updateDetails);
  @override
  List<Object> get props => [updateDetails];
}
