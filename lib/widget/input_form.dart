import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Icon? prefixIcon;
  final String? helperTxt;
  final String? Function(String?)? validator;
  const InputForm(
      {Key? key,
      this.title,
      this.controller,
      this.validator,
      this.inputType,
      this.prefixIcon,
      this.helperTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          helperText: helperTxt,
          labelText: title,
          labelStyle: const TextStyle(
            color: Color.fromARGB(225, 12, 144, 125),
          ),
          prefixIcon: prefixIcon,
          prefixIconColor: const Color.fromARGB(225, 12, 144, 125),
          // focusColor: const Color.fromARGB(225, 12, 144, 125),
          // fillColor: const Color.fromARGB(225, 12, 144, 125),
          // hoverColor: const Color.fromARGB(225, 12, 144, 125),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(225, 12, 144, 125),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: validator);
  }
}

class NonEditableForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  const NonEditableForm(
      {Key? key, this.title, this.controller, this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: prefixIcon,
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
      validator: validator,
    );
  }
}
