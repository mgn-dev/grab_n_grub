import 'package:gng_seller/widgets/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:gng_seller/widgets/custom_text.dart';

ThemeData primaryTheme = ThemeData(
  // seed color theme
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorPalette.mainAccent,
  ),

  // scaffold color
  scaffoldBackgroundColor: ColorPalette.appBackground,

  // app bar theme colors
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorPalette.appBackground,
    foregroundColor: Colors.black,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),

  // text theme
  // textTheme: TextTheme(
  //   bodyMedium: TextStyle(
  //     color: AppColors.textColor,
  //     fontSize: 16,
  //     letterSpacing: 1,
  //   ),
  //   headlineMedium: TextStyle(
  //     color: AppColors.titleColor,
  //     fontSize: 16,
  //     fontWeight: FontWeight.bold,
  //     letterSpacing: 1,
  //   ),
  //   titleMedium: TextStyle(
  //     color: AppColors.titleColor,
  //     fontSize: 18,
  //     fontWeight: FontWeight.bold,
  //     letterSpacing: 2,
  //   ),
  // ),

  // card theme
  cardTheme: const CardTheme(
    color: ColorPalette.cardBackground,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(),
    // shadowColor: Colors.transparent,
    margin: EdgeInsets.only(bottom: 16),
  ),

  // input decoration theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorPalette.inputBackground!.withOpacity(0.8),
    border: OutlineInputBorder(
      borderSide: BorderSide.none, // Removes the border line
      borderRadius: BorderRadius.circular(12.0), // Adds border radius
    ),
    labelStyle: StyledText.labelLightDark.style,
    prefixIconColor: ColorPalette.iconColor,
  ),

  // dialog theme
  // dialogTheme: DialogTheme(
  //   backgroundColor: AppColors.secondaryAccent,
  //   surfaceTintColor: AppColors.secondaryAccent,
  // ),
);
