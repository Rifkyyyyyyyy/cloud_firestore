import 'package:flutter/material.dart';

class SizeApp {
  static double kWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;
  static double kHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
  static double kIconMd = 18;
  static double kIconLg = 28;
  static double kIconXl = 32;
  
}
