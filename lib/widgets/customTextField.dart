import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  String? labelText;
  String? Function(String?)? validator;
  Widget? prefixIcon;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;

  CustomTextFormField({
    super.key,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      inputFormatters: inputFormatters,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.blue),
          prefixIcon: prefixIcon),
    );
  }
}
