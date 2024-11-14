import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/bloc/todo_bloc.dart';
import 'package:todo_app/widgets/customTextField.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'Title',
                  hintText: 'Enter your title',
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  minLines: 5,
                  maxLines: 15,
                  labelText: 'Description',
                  hintText: 'Enter your description',
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<TodoBloc>().add(AddTaskEvent(
                              title: titleController.text,
                              description: descriptionController.text));
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:todo_app/bloc/bloc/todo_bloc.dart';
// import 'package:todo_app/widgets/customTextField.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddScreen extends StatefulWidget {
//   const AddScreen({super.key});

//   @override
//   State<AddScreen> createState() => _AddScreenState();
// }

// class _AddScreenState extends State<AddScreen> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // foregroundColor: Colors.white,
//         //  backgroundColor: const Color.fromARGB(255, 65, 44, 82),
//         title: const Text(
//           "Add Your Task",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CustomTextFormField(
//                 controller: titleController,
//                 hintText: "Enter your title here ",
//                 labelText: "Title",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Titile can't be empty";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               CustomTextFormField(
//                 minLines: 8,
//                 maxLines: 12,
//                 controller: descriptionController,
//                 hintText: "Enter Description here",
//                 labelText: "Description",
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Description can't be empty";
//                   } else {
//                     return null;
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           context.read<TodoBloc>().add(AddTaskEvent(
//                               title: titleController.text,
//                               description: descriptionController.text));
//                           Navigator.pop(context);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 136, 104, 143)),
//                       child: const Text("ADD")))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
