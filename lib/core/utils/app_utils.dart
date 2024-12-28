import 'package:flutter/material.dart';

class AppScreenUtils {
  static double h = 0;
  static double w = 0;
  static bool isTablet = false;

  static void initUtils(BuildContext context) {
    h = MediaQuery.sizeOf(context).height;
    w = MediaQuery.sizeOf(context).width;
    isTablet = MediaQuery.sizeOf(context).shortestSide >= 600;
  }
}
