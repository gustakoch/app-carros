import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String message;
  TextError(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      ),
    );
  }
}
