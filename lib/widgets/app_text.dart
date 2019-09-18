import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String labelText;
  String hintText;
  bool obscureText;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;

  AppText(
    this.labelText,
    this.hintText, {
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        FocusScope.of(context).requestFocus(focusNode);
      },
      style: TextStyle(color: Colors.red, fontSize: 18),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 17),
      ),
    );
  }
}
