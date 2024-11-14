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
//                           context.read<TodoBloc>().add(UpdateTodoEvent(
//                               id: id,
//                               title: titleController.text,
//                               description: descriptionController.text));
//                           Navigator.pop(context);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 136, 104, 143)),
//                       child: const Text("Update")))
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/bloc/todo_bloc.dart';
import 'package:todo_app/widgets/customTextField.dart';

class EditScreen extends StatelessWidget {
  final String id;
  final String initialTitle;
  final String initialDescription;
  EditScreen(
      {super.key,
      required this.id,
      required this.initialTitle,
      required this.initialDescription});
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    titleController.text = initialTitle;
    descriptionController.text = initialDescription;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Your Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: titleController,
                hintText: "Enter your title here ",
                labelText: "Title",
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
                minLines: 8,
                maxLines: 12,
                controller: descriptionController,
                hintText: "Enter Description here",
                labelText: "Description",
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
                          context.read<TodoBloc>().add(UpdateTodoEvent(
                              id: id,
                              title: titleController.text,
                              description: descriptionController.text));
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan),
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      )),
    );
  }
}
