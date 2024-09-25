import 'package:flutter/material.dart';
import 'package:gng_seller/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget
{
  const LoadingDialog({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          const SizedBox(height: 10,),
          Text("${message!}, Please wait..."),
        ],
      ),
    );
  }
}
