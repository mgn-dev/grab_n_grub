import 'package:flutter/material.dart';
import 'package:gng_seller/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.function, required this.text});

  final Function() function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 55,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all(const Color.fromRGBO(126, 217, 87, 1)),
          shape: WidgetStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
        ),
        onPressed: function,
        child: CustomText(
          text: text,
          style: StyledText.labelLightWhite.style,
        ),
      ),
    );
  }
}
