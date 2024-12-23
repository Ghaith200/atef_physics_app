import 'package:flutter/material.dart';

class AppColors {
  // Singleton implementation (optional, if needed elsewhere)
  // static final AppColors _instance = AppColors._internal();
  // factory AppColors() => _instance;
  // AppColors._internal();

  // Static theme mode variable
  static bool isDarkMode = false;

  // // Static color definitions
  static const Color blue = Color(0xFF0096FF);

  static const Color red = Color.fromARGB(255, 255, 0, 0);
  // // static const Color gery = Colors.grey;

  // // Background color depending on dark mode
  static Color get blackWhite => isDarkMode ? Colors.black : Colors.white;

  static Color get whiteBlack => isDarkMode ? Colors.white : Colors.black;

  static Color get grey =>
      isDarkMode ? Colors.grey.shade500 : Colors.grey.shade700;

  static ColorScheme get lightScheme => ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: blue,
      );
  static ColorScheme get darkScheme => ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: blue,
      );
  static ColorScheme get scheme => isDarkMode ? darkScheme : lightScheme;

  // static final ThemeData lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Color(0xFF002DE3),
  //   colorScheme: ColorScheme(
  //       brightness: brightness,
  //       primary: primary,
  //       onPrimary: onPrimary,
  //       secondary: secondary,
  //       onSecondary: onSecondary,
  //       error: error,
  //       onError: onError,
  //       surface: surface,
  //       onSurface: onSurface),
  //   appBarTheme: const AppBarTheme(
  //     color: Colors.white,
  //   ),
  //   //make the color of selection color to be green and change the color of handle
  //   textSelectionTheme: TextSelectionThemeData(
  //     selectionColor: ColorName.green.withOpacity(0.5),
  //     selectionHandleColor: ColorName.green,
  //   ),
  //   fontFamily: FontFamily.alexandria,
  //   useMaterial3: true,
  //   scaffoldBackgroundColor: Colors.white,
  // );

  // static final ThemeData dartTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Color(0xFF002DE3),
  //   scaffoldBackgroundColor: Colors.white12,
  // );

  // static ThemeData get theme => isDarkMode ? dartTheme : lightTheme;
}
