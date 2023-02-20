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

class NonEditableForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  const NonEditableForm({Key? key, this.title, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      readOnly: true,
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
    );
  }
}

class InputNumberForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const InputNumberForm({Key? key, this.title, this.controller, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.number,
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
        validator: validator,);
  }
}