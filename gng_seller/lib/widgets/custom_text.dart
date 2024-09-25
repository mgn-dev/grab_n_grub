import 'package:flutter/material.dart';
import 'package:gng_seller/widgets/color_palette.dart';

enum StyledText {
  bodyHeading(
      style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: ColorPalette.textColor,
  )),
  bodySubheading(
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: ColorPalette.textColor,
    )
  ),
  bodyText(
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: ColorPalette.textColor,
    )
  ),
  labelLightWhite(
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: ColorPalette.textAltColor,
    )
  ),
  labelLightDark(
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: ColorPalette.textColor,
    )
  ),
  labelHeavyDark(
    style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: ColorPalette.textColor,
    )
  ),
  labelHeavyWhite(
    style: TextStyle(
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: ColorPalette.textAltColor,
    )
  );
  // titleLarge(),
  // titleMedium();

  const StyledText({
    required this.style,
  });

  final TextStyle style;
}

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
