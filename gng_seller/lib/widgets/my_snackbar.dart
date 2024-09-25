import 'package:flutter/material.dart';

class MySnackbar {
  static void set(BuildContext context, String text) {
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
