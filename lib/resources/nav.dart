import 'package:flutter/material.dart';

Future push(context, Widget page, {bool replace = false}) {
  if (replace) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}
