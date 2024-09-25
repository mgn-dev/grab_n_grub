import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget
{
  const ErrorDialog({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    Navigator.pop(context);
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: ()
          {
            Navigator.pop(context);
          },
          child: const Center(
            child: Text("OK"),
          ),
        ),
      ],
    );
  }
}
