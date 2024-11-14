import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/bloc/todo_bloc.dart';
import 'package:todo_app/screens/add_screen.dart';
import 'package:todo_app/screens/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(FetchTodoEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg)),
            );
          } else if (state is TodoSuccess && state.isTaskAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task added Successfully')));
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoSuccess) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final task = state.items[index];
                  return Card(
                    color: Colors.cyan,
                    child: ListTile(
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      title: Text(task['title']),
                      subtitle: Text(task['description']),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                          id: task['_id'],
                                          initialTitle: task['title'],
                                          initialDescription:
                                              task['description'],
                                        ))).then((_) {
                              context.read<TodoBloc>().add(FetchTodoEvent());
                            });
                          } else if (value == 'delete') {
                            context
                                .read<TodoBloc>()
                                .add(DeleteTodoEvent(task['_id']));
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text("Edit"),
                            ),
                            const PopupMenuItem(
                                value: 'delete', child: Text('Delete'))
                          ];
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is TodoError) {
            return Center(
              child: Text(state.msg),
            );
          }
          return const Center(
            child: Text('No tasks available',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddScreen()));
            context.read<TodoBloc>().add(FetchTodoEvent());
          },
          label: const Icon(Icons.add)),
    );
  }
}
