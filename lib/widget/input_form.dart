import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const InputForm({Key? key, this.title, this.controller, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: validator);
  }
}
