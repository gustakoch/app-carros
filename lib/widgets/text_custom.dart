import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  String nomeCarro;
  Color color;
  double fontSize;
  bool bold;

  TextCustom(
    this.nomeCarro, {
    this.color = Colors.black,
    this.fontSize = 16,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      nomeCarro,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
